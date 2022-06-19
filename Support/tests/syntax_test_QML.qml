// SYNTAX TEST "Packages/Sublime-QML/Support/QML.sublime-syntax"

pragma Singleton
// <-  meta.pragma keyword.control.pragma
// ^^^ meta.pragma keyword.control.pragma
//     ^^^^^^^^^ meta.pragma storage.modifier.singleton

import QtQml
// <- source.qml meta.import keyword.control.import
//     ^^^^^ meta.path

import QtQuick.Layouts 2.15
// <- meta.import keyword.control.import
//     ^^^^^^^         meta.import meta.path
//            ^        meta.import punctuation.accessor.dot
//             ^^^^^^^ meta.import meta.path
//                     ^ constant.numeric
//                      ^ punctuation.separator
//                       ^^ constant.numeric

import org.kde.kirigami 2.20 as Kirigami
//                           ^^ keyword.operator.as
//                              ^^^^^^^^ entity.name.namespace

import ":/components"
//     ^^^^^^^^^^^^^^ meta.string string.quoted.double

// Make sure import aliases work with strings
import "./logic.js" as Logic
//                  ^^ meta.import meta.import.alias keyword.operator.as

QtObject {}
// <- support.type
// ^^^^^ support.type

Kirigami.TextField {/**/}
// ^^^^^ entity.name.namespace
//      ^ punctuation.accessor.dot
//       ^^^^^^^^^ support.type
//                 ^^^^^^ meta.block.qml
//                 ^ punctuation.section.braces.begin
//                  ^^^^ comment.block
//                      ^ punctuation.section.braces.end

one.two {}
// <-   - entity.name.namespace - support.type
//  ^^^ - entity.name.namespace - support.type
one.two.three {}
//  ^^^ - entity.name.namespace - support.type
