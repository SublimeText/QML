// SYNTAX TEST "Packages/Sublime-QML/Support/QML.sublime-syntax"

pragma Singleton
// <-  meta.pragma keyword.control.pragma
// ^^^ meta.pragma keyword.control.pragma
//     ^^^^^^^^^ meta.pragma storage.modifier.singleton

/* no version */
import QtQml
// <- source.qml meta.import keyword.control.import
//     ^^^^^ meta.path

/* major-only version */
import QtQuick 2
//             ^ meta.import constant.numeric

import QtQuick 2 . 15
//             ^^^^^^ meta.import meta.number.version
//               ^ punctuation.separator.decimal

/* major & minor version */
import QtQuick.Layouts 2.15
// <- meta.import keyword.control.import
//     ^^^^^^^^^^^^^^^ meta.path
//            ^ punctuation.accessor
//                     ^ constant.numeric
//                      ^ punctuation.separator
//                       ^^ constant.numeric
// ^^^^^^^^^^^^^^^^^^^^^^^^ meta.import.qml

import org.kde.kirigami 2.20 as Kirigami
//                           ^^ keyword.operator.as
//                              ^^^^^^^^ entity.name.namespace

import QtQuick.Controls @QQC2_VERSION@ as Controls;
//                      ^^^^^^^^^^^^^^ variable.other.cmake
//                      ^              punctuation.definition.variable.begin.cmake
//                                   ^ punctuation.definition.variable.end.cmake
//                                     ^^ meta.import keyword.operator.as
//                                                ^ punctuation.terminator.statement

import Abc as abc
//            ^^^ meta.import.alias invalid.illegal.name.import

import ":/components"
//     ^^^^^^^^^^^^^^ meta.string string.quoted.double

// Make sure import aliases work with strings
import "./logic.js" as Logic
//                  ^^ meta.import meta.import.alias keyword.operator.as

import One; import Two;
//        ^             punctuation.terminator.statement.qml - punctuation.terminator.statement.empty
//                    ^ punctuation.terminator.statement.qml - punctuation.terminator.statement.empty


QtObject {}
// <- support.class
// ^^^^^ support.class

Kirigami.TextField {/**/}
// ^^^^^ support.class
//      ^ punctuation.accessor
//       ^^^^^^^^^ support.class
//                 ^^^^^^ meta.block.qml
//                 ^ punctuation.section.block.begin
//                  ^^^^ comment.block
//                      ^ punctuation.section.block.end

Nested {
// ^^^ support.class
//     ^ meta.block
    Inner {}
//  ^^^^^ meta.block support.class
//        ^^ meta.block meta.block
    Foo.Bar {}
//  ^^^ meta.block support.class
//      ^^^ meta.block support.class
//          ^^ meta.block meta.block
}
// <- meta.block punctuation.section.block.end

// <- - meta.block

one.two {}
// <-   - support.class
//  ^^^ - support.class
one.two.three {}
//  ^^^ - support.class

WithId {
    id: one two
//  ^^^^^^^ meta.binding
//    ^ keyword.operator.assignment
//      ^^^ entity.name.label
//          ^^^ invalid.illegal
    id : three
//     ^ meta.binding keyword.operator.assignment
//       ^^^^^ entity.name.label
    id: Four
//      ^^^^ invalid.illegal.identifier
    id: 5
//      ^ invalid.illegal.identifier
    id 6
//  ^^ meta.binding
//     ^ invalid.illegal
    id /*comment*/ : /**
        */ seven/**/
//         ^^^^^ entity.name.label
//              ^^^^ comment.block
    id: eight; id: nine/**/; id: ten
//           ^ punctuation.terminator.statement
//  ^^^^^^^^^  meta.binding
//             ^^^^^^^^ meta.binding
//                     ^^^^ comment.block
//                           ^^^^^^^ meta.binding
    id: break
//      ^^^^^ invalid.illegal.identifier
}

RequiredProperties {
    required name; required /**/ text
//  ^^^^^^^^^^^^^ meta.binding
//                 ^^^^^^^^^^^^^^^^^^ meta.binding
//               ^^ - meta.binding
//  ^^^^^^^^ storage.modifier.required
//           ^^^^ meta.binding.name variable.other.member
//               ^ punctuation.terminator.statement
//                          ^^^^ comment.block
//                               ^^^^ meta.binding.name variable.other.member
    required Four
//           ^^^^ meta.binding.name variable.other.member
    required 5
//           ^ invalid.illegal.expected-name
    required break
//           ^^^^^ invalid.illegal.expected-name
    required prop: 42
//  ^^^^^^^^^^^^^ meta.binding
//               ^ invalid.illegal.binding
    required foo bar
//           ^^^ invalid.illegal.expected-property
    required break;
//           ^^^^^ invalid.illegal.expected-name
/* Apparently, these are valid property names in QML */
    required required
//           ^^^^^^^^ meta.binding.name variable.other.member - invalid.illegal
    required property
//           ^^^^^^^^ meta.binding.name variable.other.member - invalid.illegal
    required property int nine
//  ^^^^^^^^ keyword.other storage.modifier.required
//           ^^^^^^^^ keyword.declaration
//                    ^^^ storage.type support.type
//                        ^^^^ meta.binding.name variable.other.member
    required property url ten: 10
//                           ^ invalid.illegal.binding
    required property list<url> eight
//                    ^^^^ storage.type support.other
//                        ^ punctuation.definition.generic.begin
//                         ^^^ storage.type support.type
//                            ^ punctuation.definition.generic.end
//                              ^^^^^ meta.binding.name variable.other.member
    required property list<Item> seven
//                    ^^^^ storage.type support.other
//                        ^ punctuation.definition.generic.begin
//                         ^^^^ support.class.qml
//                             ^ punctuation.definition.generic.end
//                               ^^^^^ meta.binding.name variable.other.member
    required property list<QtQuick.Item> seven
//                    ^^^^ storage.type support.other
//                        ^ punctuation.definition.generic.begin
//                         ^^^^^^^ support.class.qml
//                                ^ punctuation.accessor
//                                 ^^^^ support.class.qml
//                                     ^ punctuation.definition.generic.end
//                                       ^^^^^ meta.binding.name variable.other.member
    required property what isthis
//                    ^^^^ storage.type.qml - support.type
//                         ^^^^^^ meta.binding.name variable.other.member
    required property what for
//                         ^^^ invalid.illegal.expected-identifier.qml
}
