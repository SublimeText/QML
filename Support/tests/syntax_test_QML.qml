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

Nested {
// ^^^ support.type
//     ^ meta.block
    Inner {}
//  ^^^^^ meta.block support.type
//        ^^ meta.block meta.block
    Foo.Bar {}
//  ^^^ meta.block entity.name.namespace
//      ^^^ meta.block support.type
//          ^^ meta.block meta.block
}
// <- meta.block punctuation.section.braces.end

// <- - meta.block

one.two {}
// <-   - entity.name.namespace - support.type
//  ^^^ - entity.name.namespace - support.type
one.two.three {}
//  ^^^ - entity.name.namespace - support.type

WithId {
    id: one two
//  ^^^^^^^ meta.mapping
//    ^ keyword.operator.assignment
//      ^^^ entity.name.label
//          ^^^ invalid.illegal
    id : three
//     ^ meta.mapping keyword.operator.assignment
//       ^^^^^ entity.name.label
    id: Four
//      ^^^^ invalid.illegal.identifier
    id: 5
//      ^ invalid.illegal.identifier
    id 6
//  ^^ meta.mapping
//     ^ invalid.illegal
    id /*comment*/ : /**
        */ seven/**/
//         ^^^^^ entity.name.label
//              ^^^^ comment.block
    id: eight; id: nine/**/; id: ten
//           ^ punctuation.terminator.statement
//  ^^^^^^^^^  meta.mapping
//           ^^ - meta.mapping
//             ^^^^^^^^ meta.mapping
//                     ^^^^ comment.block
//                     ^^^^^^ - meta.mapping
//                           ^^^^^^^ meta.mapping
    id: break
//      ^^^^^ invalid.illegal.identifier
}
