# SPDX-FileCopyrightText: 2023 ivan tkachenko <me@ratijas.tk>
# SPDX-License-Identifier: MIT

import re
import sys
from typing import Iterable, List, Optional, Union

import sublime
from sublime import Region

from unittest import TestCase
from unittesting import DeferrableTestCase

import QML.QMLCommands as qml


class TestConvertBetweenPropertyAndSignalHandler(DeferrableTestCase):
    def setUp(self):
        # make sure we have a window to work with
        s = sublime.load_settings("Preferences.sublime-settings")
        s.set("close_windows_when_empty", False)
        self.view = sublime.active_window().new_file()
        self.view.assign_syntax("scope:source.qml")

    def tearDown(self):
        self.view.set_scratch(True)
        self.view.window().focus_view(self.view)  # pyright: ignore [reportOptionalMemberAccess]
        self.view.window().run_command("close_file")  # pyright: ignore [reportOptionalMemberAccess]

    def setText(self, string: str):
        self.view.run_command("select_all")
        self.view.run_command("left_delete")
        self.view.run_command("insert", {"characters": string})

    def getRow(self, row: int):
        return self.view.substr(self.view.line(self.view.text_point(row, 0)))

    def runBasicParserTest(self, parser: qml.Parser, string: str, point: qml.Point, expected: Optional[Region]):
        self.setText(string)
        actual = parser(self.view, point)
        self.assertEqual(actual, expected)

    def test_atoms(self):
        self.runBasicParserTest(qml.Atoms.dot, ".", 0, Region(0, 1))
        self.runBasicParserTest(qml.Atoms.dot, ".", 1, None)
        self.runBasicParserTest(qml.Atoms.dot, "abc.", 0, None)
        self.runBasicParserTest(qml.Atoms.dot, "abc.", 3, Region(3, 4))
        self.runBasicParserTest(qml.Atoms.dot, "abc.def", 4, None)

        self.runBasicParserTest(qml.Atoms.identifier, "abc", 0, Region(0, 3))
        self.runBasicParserTest(qml.Atoms.identifier, "abc", 3, Region(0, 3))
        self.runBasicParserTest(qml.Atoms.identifier, "abc.", 3, Region(0, 3))
        self.runBasicParserTest(qml.Atoms.identifier, "abc.", 4, None)
        self.runBasicParserTest(qml.Atoms.identifier, "abc123", 0, Region(0, 6))
        self.runBasicParserTest(qml.Atoms.identifier, "abc123:", 0, Region(0, 6))
        self.runBasicParserTest(qml.Atoms.identifier, "abc123:", 5, Region(0, 6))

    def test_locate_last_identifier(self):
        self.runBasicParserTest(qml.last_identifier, "ABC.Def.xyz", 5, Region(8, 11))
        self.runBasicParserTest(qml.last_identifier, "ABC.Def.xyz: 42", 5, Region(8, 11))

    def runCommandTest(self, string: str, regions: Iterable[Union[Region, qml.Point]], expected_string: str, expected_regions: List[Region]):
        yield 0  # turn this function into generator, convenient for testing

        self.setText(string)
        self.view.sel().clear()
        self.view.sel().add_all(regions)
        self.view.run_command("convert_between_property_and_signal_handler")
        self.view.run_command("select_all")
        text = self.view.substr(self.view.sel()[0])
        self.view.run_command("soft_undo")

        self.assertEqual(text, expected_string)
        self.assertEqual(list(self.view.sel()), expected_regions)

    def test_convert_command(self):
        yield from self.runCommandTest("abc.def", [0], "abc.onDefChanged: ", [Region(18)])
        yield from self.runCommandTest("abc.def\nxyz: 123", [0, 8], "abc.onDefChanged: \nonXyzChanged: 123", [Region(18), Region(33)])
        yield from self.runCommandTest("abc.onDefChanged", [0], "abc.def: ", [Region(9)])
        yield from self.runCommandTest("abc.onDefChanged\nonXyzChanged: 123", [0, 17], "abc.def: \nxyz: 123", [Region(9), Region(15)])
        yield from self.runCommandTest("_pressed:", [0], "on_PressedChanged: ", [Region(19)])


class TestStringUnits(TestCase):
    def test_substring(self):
        string = "abc123def"
        m = re.search("123", string)
        self.assertIsNotNone(m)
        span = m.span() # pyright: ignore [reportOptionalMemberAccess]
        self.assertEqual("123", qml.substring(string, span))

    def test_string_splice(self):
        string = "abc123def"
        m = re.search("123", string)
        self.assertIsNotNone(m)
        span = m.span() # pyright: ignore [reportOptionalMemberAccess]
        qml.string_splice(string, span, "xyz")
        self.assertEqual("abcxyzdef", qml.string_splice(string, span, "xyz"))


class TestFunctions(TestCase):
    def test_replace_property(self):
        replacement = qml.generate_replacement_for("hoverEnabled")
        self.assertEqual(replacement, "onHoverEnabledChanged")

        replacement = qml.generate_replacement_for("ABC")
        self.assertEqual(replacement, "onABCChanged")

    def test_replace_property_with_underscores(self):
        replacement = qml.generate_replacement_for("_abc")
        self.assertEqual(replacement, "on_AbcChanged")

        replacement = qml.generate_replacement_for("__internal")
        self.assertEqual(replacement, "on__InternalChanged")

    def test_replace_broken_property(self):
        replacement = qml.generate_replacement_for("_12")
        self.assertIsNone(replacement)

    def test_replace_signal_handler(self):
        replacement = qml.generate_replacement_for("onHoverEnabledChanged")
        self.assertEqual(replacement, "hoverEnabled")

        replacement = qml.generate_replacement_for("onToggled")
        self.assertEqual(replacement, "toggled")

    def test_replace_signal_handler_with_underscores(self):
        replacement = qml.generate_replacement_for("on__InternalChanged")
        self.assertEqual(replacement, "__internal")

        replacement = qml.generate_replacement_for("on__Pressed")
        self.assertEqual(replacement, "__pressed")

    def test_replace_unknown(self):
        replacement = qml.generate_replacement_for("123")
        self.assertIsNone(replacement)

        replacement = qml.generate_replacement_for("#$%")
        self.assertIsNone(replacement)
