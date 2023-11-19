# SPDX-FileCopyrightText: 2023 ivan tkachenko <me@ratijas.tk>
# SPDX-License-Identifier: MIT

from dataclasses import dataclass
from typing import Callable, List, Optional, Tuple
import sublime
from sublime import Region
import sublime_plugin
import re

# Apparently, sublime module claims to have Point member as a type alias to int, but in fact it doesn't
Point = int

Parser = Callable[[sublime.View, Point], Optional[Region]]

# Based on QML.sublime-syntax, except that
# Python regex lacks [:groups:] support
IDENTIFIER = re.compile(r"\b_*([a-zA-Z])\w*\b")
IDENTIFIER_HANDLER = re.compile(rf"\b(?:on)(_*([A-Z])\w*?)(Changed)?\b")


class Atoms:
    """
    Atoms parsers.
    """

    @staticmethod
    def dot(view: sublime.View, point: Point) -> Optional[Region]:
        region = Region(point, point + 1)

        if view.substr(region) == ".":
            return region

        return None


    @staticmethod
    def identifier(view: sublime.View, point: Point) -> Optional[Region]:
        region = view.word(point)
        if region is None:
            return None

        word = view.substr(region)
        if IDENTIFIER.fullmatch(word) is None:
            return None

        return region


class Combinators:
    """
    Simple parser combinators.
    """

    @staticmethod
    def last_delimited(parser: Parser, separator: Parser) -> Parser:
        def parse(view: sublime.View, point: Point) -> Optional[Region]:
            last = result = parser(view, point)

            if result is not None:
                point = result.end()

            while True:
                result = separator(view, point)
                if result is None:
                    return last

                point = result.end()

                result = parser(view, point)

                if result is None:
                    return last

                last = result
                point = result.end()

        return parse


last_identifier = Combinators.last_delimited(Atoms.identifier, Atoms.dot)
"""
Get last identifier in a dot-separated series, like
- "margins" in `anchors.margins`,
- "onCompleted" in `Component.onCompleted`,
- or "visible" in `QQC2.ToolTip.visible`.
"""


def substring(string: str, span: Tuple[int, int]) -> str:
    start, end = span
    return string[start:end]


def string_splice(string: str, span: Tuple[int, int], new: str) -> str:
    start, end = span
    return string[:start] + new + string[end:]


def string_splice_apply(string: str, span: Tuple[int, int], fn: Callable[[str], str]) -> str:
    new = fn(substring(string, span))
    return string_splice(string, span, new)


def generate_replacement_for(string: str) -> Optional[str]:
    match_handler = IDENTIFIER_HANDLER.fullmatch(string)
    match_identifier = IDENTIFIER.fullmatch(string)

    if match_handler is not None:
        property_name = string_splice_apply(string, match_handler.span(2), str.lower)
        property_name = substring(property_name, match_handler.span(1))
        return property_name

    elif match_identifier is not None:
        property_uppercased = string_splice_apply(string, match_identifier.span(1), str.upper)
        signal_handler_name = f"on{property_uppercased}Changed"
        return signal_handler_name

    return None


def common_prefix(first: str, second: str) -> str:
    i = 0
    shortest = min(len(first), len(second))
    while i < shortest and first[i] == second[i]:
        i += 1
    return first[:i]


@dataclass
class Replacement:
    original_selection_region: Region
    source_region: Region
    replacement_string: str


class ConvertBetweenPropertyAndSignalHandler(sublime_plugin.TextCommand):
    def run(self, edit: sublime.Edit):
        signal_handlers: List[Replacement] = []
        properties: List[Replacement] = []

        for original_selection_region in self.view.sel():
            point = original_selection_region.b
            scope = self.view.scope_name(point)

            if "source.qml" not in scope and "text.plain" not in scope:
                continue

            identifier_region = last_identifier(self.view, original_selection_region.b)
            if identifier_region is None:
                continue

            target = []

            if IDENTIFIER_HANDLER.fullmatch(self.view.substr(identifier_region)):
                target = signal_handlers
            elif IDENTIFIER.fullmatch(self.view.substr(identifier_region)):
                target = properties
            else:
                continue

            identifier_string = self.view.substr(identifier_region)
            replacement_string = generate_replacement_for(identifier_string)
            if replacement_string is None:
                continue

            # Insert ": " if needed, and set selection to the point after the whitespace
            extra_string = ": "
            lookahead = self.view.substr(Region(identifier_region.end(), identifier_region.end() + len(extra_string)))
            extra_preexisting = common_prefix(lookahead, extra_string)

            source_region = Region(identifier_region.a, identifier_region.b + len(extra_preexisting))
            replacement_string += extra_string

            target.append(Replacement(original_selection_region, source_region, replacement_string))

        # If there are no properties, change all signal handlers to
        # properties, otherwise change all properties to signal handlers.
        regions = signal_handlers if len(properties) == 0 else properties

        # Regions are maintained by selection in sorted order, so it should be
        # reversed to apply changes down below before those which come
        # earlier, so they don't shift regions downward.
        for replacement in reversed(regions):
            target_selection_region = Region(replacement.source_region.begin() + len(replacement.replacement_string))

            self.view.sel().subtract(replacement.original_selection_region)
            self.view.replace(edit, replacement.source_region, replacement.replacement_string)
            self.view.sel().add(target_selection_region)
