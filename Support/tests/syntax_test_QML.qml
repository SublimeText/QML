// SYNTAX TEST "Packages/QML/Support/QML.sublime-syntax"

pragma Singleton
// <-  meta.pragma keyword.control.pragma
// ^^^^^^^^^^^^^ meta.pragma.qml
//     ^^^^^^^^^ storage.modifier.pragma

pragma Strict
// <-  meta.pragma keyword.control.pragma
// ^^^^^^^^^^ meta.pragma.qml
//     ^^^^^^ storage.modifier.pragma

pragma ComponentBehavior: Bound
// <-  meta.pragma keyword.control.pragma
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.pragma.qml
//     ^^^^^^^^^^^^^^^^^ storage.modifier.pragma
//                      ^ punctuation.separator.mapping.key-value
//                        ^^^^^ storage.modifier.pragma

/* no version */
import QtQml
// <- source.qml meta.import keyword.control.import
//     ^^^^^ meta.path meta.generic-name

/* major-only version */
import QtQuick 2
// <-               meta.import.qml
// ^^^^^^^^^^^^^    meta.import.qml
//              ^ - meta.import.qml
//             ^ meta.import constant.numeric

import QtQuick 2 . 15
//             ^^^^^^ meta.import meta.number.version
//               ^ punctuation.separator.decimal

/* major & minor version */
import QtQuick.Layouts 2.15
// <-                          meta.import.qml
// ^^^^^^^^^^^^^^^^^^^^^^^^    meta.import.qml
//                         ^ - meta.import.qml
// <- meta.import keyword.control.import
//     ^^^^^^^^^^^^^^^ meta.path
//            ^ punctuation.accessor
//                     ^^^^ meta.number.version
//                     ^ constant.numeric
//                      ^ punctuation.separator
//                       ^^ constant.numeric

import org.kde . kirigami 2.20 as Kirigami
// <-                                       meta.import.qml
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    meta.import.qml
//                                        ^ - meta.import.qml
//                        ^^^^ meta.number.version
//                             ^^ keyword.operator.as
//                                ^^^^^^^^ meta.import.alias entity.name.namespace

import QtQuick.Controls as Controls
// <-                                  meta.import.qml
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    meta.import.qml
//                                 ^ - meta.import.qml
//     ^^^^^^^^^^^^^^^^ meta.path
//     ^^^^^^^ meta.generic-name
//            ^ punctuation.accessor
//             ^^^^^^^^ meta.generic-name
//                      ^^ keyword.operator.as
//                         ^^^^^^^^ meta.import.alias entity.name.namespace

import QtQuick.Controls @QQC2_VERSION@ as Controls;
// <-                                               meta.import.qml
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.import.qml
//                                                 ^ - meta.import.qml
//     ^^^^^^^^^^^^^^^^ meta.path
//     ^^^^^^^ meta.generic-name
//            ^ punctuation.accessor
//             ^^^^^^^^ meta.generic-name
//                      ^^^^^^^^^^^^^^ variable.other.cmake
//                      ^              punctuation.definition.variable.begin.cmake
//                                   ^ punctuation.definition.variable.end.cmake
//                                     ^^ meta.import keyword.operator.as
//                                                ^ punctuation.terminator.statement

import Abc as abc
//            ^^^ meta.import.alias invalid.illegal.name.import

import ":/components"
//     ^^^^^^^^^^^^^^ meta.string string.quoted.double

import ':/components' 2.5 as Components
// <-                                   meta.import.qml
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.import.qml
//                                     ^ - meta.import.qml
//     ^^^^^^^^^^^^^^ meta.string string.quoted.single
//                    ^^^ meta.number.version

// Make sure import aliases work with strings
import "./logic.js" as Logic
//                  ^^ meta.import meta.import.alias keyword.operator.as

import `templates`
//     ^^^^^^^^^^^ meta.import.qml invalid.illegal.import-string meta.string string.quoted.other

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
    Behavior on height { NumberAnimation {} }
//  ^^^^^^^^ meta.block support.class
//           ^^ keyword.other.on.qml
//              ^^^^^^ meta.binding.name.qml
//                     ^^^^^^^^^^^^^^^^^^^^^^ meta.block meta.block
//                       ^^^^^^^^^^^^^^^ support.class
    Behavior on border.color
//              ^^^^^^^^^^^^ meta.binding.name.qml
//              ^^^^^^ meta.binding.name.qml
//                    ^ punctuation.accessor
//                     ^^^^^ meta.binding.name.qml
    { NumberAnimation {} }
//    ^^^^^^^^^^^^^^^ support.class.qml
    Behavior on width
//  ^^^^^^^^ meta.block support.class
//           ^^ keyword.other.on.qml
//              ^^^^^ meta.binding.name.qml
    Behavior
//  ^^^^^^^^ meta.block support.class
    Behavior on Layout.preferredWidth {}
//  ^^^^^^^^ meta.block support.class
//           ^^ keyword.other.on.qml
//              ^^^^^^^^^^^^^^^^^^^^^^ meta.binding.name.qml
//              ^^^^^^ support.class
//                    ^ punctuation.accessor
}
// <- meta.block punctuation.section.block.end

// <- - meta.block

)
// <- invalid.illegal.stray-bracket-end
}
// <- invalid.illegal.stray-bracket-end
]
// <- invalid.illegal.stray-bracket-end

QtObject {
    )
    // <- invalid.illegal.stray-bracket-end
    ]
    // <- invalid.illegal.stray-bracket-end
}

one.two {}
// <-   - support.class
//  ^^^ - support.class
one.two.three {}
//  ^^^ - support.class

WithId {
    id: one two
//  ^^^^^^^ meta.binding.property.qml
//    ^ keyword.operator.assignment
//      ^^^ entity.name.label
    id : three
//     ^ meta.binding.property.qml keyword.operator.assignment
//       ^^^^^ entity.name.label
    id: Four
//      ^^^^ invalid.illegal.identifier
    id: 5
//      ^ invalid.illegal.identifier
    id 6
//  ^^ meta.binding.property.qml
//     ^ invalid.illegal
    id /*comment*/ : /**
        */ seven/**/
//         ^^^^^ entity.name.label
//              ^^^^ comment.block
    id: eight; id: nine/**/; id: ten
//           ^ punctuation.terminator.statement
//  ^^^^^^^^^ meta.binding.property.qml
//             ^^^^^^^^ meta.binding.property.qml
//                     ^^^^ comment.block
//                           ^^^^^^^ meta.binding.property.qml
    id: __eleven
//  ^^^^^^^^^^^^ meta.binding.property.qml
//      ^^^^^^^^ entity.name.label
    id: __Twelve
//  ^^^^^^^^^^^^ meta.binding.property.qml
//      ^^^^^^^^ invalid.illegal
    id: break
//      ^^^^^ invalid.illegal.identifier
}
OnlyId { id: only }
//       ^^^^^^^^ meta.binding.property.qml
//       ^^ keyword.other.id.qml
//         ^ keyword.operator.assignment.qml
//                ^ - meta.binding & - invalid.illegal

RequiredProperties {
    required name;; required /**/ text
//  ^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^^ storage.modifier.required
//           ^^^^ meta.binding.name variable.other.member
//               ^ punctuation.terminator.statement
//                ^^ - meta.binding.property.qml
//                ^ invalid.illegal.unexpected-terminator.qml
//                  ^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//                           ^^^^ comment.block
//                                ^^^^ meta.binding.name variable.other.member
    required Four
//           ^^^^ invalid.illegal.expected-name
    required 5
//           ^ invalid.illegal.expected-name
    required break
//           ^^^^^ invalid.illegal.expected-name
    required prop: 42
//  ^^^^^^^^^^^^^ meta.binding.property.qml
//               ^ punctuation.separator.mapping.key-value.qml invalid.illegal.binding
//                 ^^ meta.number.integer.decimal.js constant.numeric.value.js
    required foo bar
//           ^^^ invalid.illegal.expected-property
    required break;
//           ^^^^^ invalid.illegal.expected-name
/* Apparently, these are valid property names in QML */
    required required
//           ^^^^^^^^ meta.binding.name variable.other.member - invalid.illegal
    required property
//           ^^^^^^^^ meta.binding.name variable.other.member - invalid.illegal
    required property var modelData
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property
//  ^^^^^^^^ keyword.other storage.modifier.required
//           ^^^^^^^^ keyword.declaration
//                    ^^^ storage.type support.other
//                        ^^^^^^^^^ meta.binding.name variable.other.member
    required property varia modelData
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property
//  ^^^^^^^^ keyword.other storage.modifier.required
//           ^^^^^^^^ keyword.declaration
//                    ^^^^^ - storage.type
//                          ^^^^^^^^^ meta.binding.name variable.other.member
    required property variant modelData
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property
//  ^^^^^^^^ keyword.other storage.modifier.required
//           ^^^^^^^^ keyword.declaration
//                    ^^^^^^^ storage.type support.other invalid.deprecated.variant
//                            ^^^^^^^^^ meta.binding.name variable.other.member
    required property int nine;;
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property
//  ^^^^^^^^ keyword.other storage.modifier.required
//           ^^^^^^^^ keyword.declaration
//                    ^^^ support.type
//                        ^^^^ meta.binding.name variable.other.member
//                            ^ punctuation.terminator.statement.qml
//                             ^ invalid.illegal.unexpected-terminator.qml - meta.binding.property
    required property url ten:
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property
//                           ^ punctuation.separator.mapping.key-value.qml invalid.illegal.binding
        10
//      ^^^ meta.binding.property
//      ^^ meta.number.integer.decimal.js constant.numeric.value.js
    required property list<url> eight
//                    ^^^^ storage.type support.other
//                        ^ punctuation.definition.generic.begin
//                         ^^^ support.type
//                            ^ punctuation.definition.generic.end
//                              ^^^^^ meta.binding.name variable.other.member
    required property list<custom> gadgets
//                    ^^^^ storage.type support.other
//                        ^ punctuation.definition.generic.begin
//                         ^^^^^^ meta.type.qml
//                               ^ punctuation.definition.generic.end
//                                 ^^^^^^^ meta.binding.name variable.other.member
    required property list<Item> seven
//                    ^^^^ storage.type support.other
//                        ^ punctuation.definition.generic.begin
//                         ^^^^ support.class
//                             ^ punctuation.definition.generic.end
//                               ^^^^^ meta.binding.name variable.other.member
    required property list<QtQuick.Item> six
//                    ^^^^ storage.type support.other
//                        ^ punctuation.definition.generic.begin
//                         ^^^^^^^ support.class
//                                ^ punctuation.accessor
//                                 ^^^^ support.class
//                                     ^ punctuation.definition.generic.end
//                                       ^^^ meta.binding.name variable.other.member
    required property what isthis
//                    ^^^^ - storage.type.qml & - support.type
//                         ^^^^^^ meta.binding.name variable.other.member
    required property what for
//                         ^^^ invalid.illegal.expected-identifier.qml
    required default property string name: "abc"
//  ^^^^^^^^ keyword.other storage.modifier.required
//           ^^^^^^^ keyword.other storage.modifier.default
//                   ^^^^^^^^ keyword.declaration
//                                       ^ punctuation.separator.mapping.key-value.qml invalid.illegal.binding
    default required property string name: "xyz"
//  ^^^^^^^ keyword.other storage.modifier.default
//          ^^^^^^^^ keyword.other storage.modifier.required
//                   ^^^^^^^^ keyword.declaration
//                                       ^ punctuation.separator.mapping.key-value.qml invalid.illegal.binding
}
Item {required modelData}
//   ^^^^^^^^^^^^^^^^^^^^ meta.block
//                       ^ - meta.block
//    ^^^^^^^^^^^^^^^^^^ meta.binding.property
//    ^^^^^^^^ keyword.other storage.modifier.required
//             ^^^^^^^^^ meta.binding.name variable.other.member
//                      ^ punctuation.section.block.end.qml - invalid.illegal

RegularProperties {
    property color bright
//  ^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^^ keyword.declaration
//           ^^^^^ support.type
//                 ^^^^^^ meta.binding.name variable.other.member
    property color bright;
//  ^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//                       ^ punctuation.terminator.statement
//                        ^ meta.block - meta.binding.property.qml
    property Item child;
//  ^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^^ keyword.declaration
//           ^^^^ support.class
//                ^^^^^ meta.binding.name variable.other.member
//                     ^ punctuation.terminator.statement
    property QQC2.Button button
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^^ keyword.declaration
//           ^^^^ support.class
//               ^ punctuation.accessor
//                ^^^^^^ support.class
//                       ^^^^^^ meta.binding.name variable.other.member
    property list<Item> children
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^^ keyword.declaration
//           ^^^^ storage.type support.other
//               ^ punctuation.definition.generic.begin
//                ^^^^ support.class
//                    ^ punctuation.definition.generic.end
//                      ^^^^^^^^ meta.binding.name variable.other.member
    property alias those: root.background.children
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^^ keyword.declaration
//           ^^^^^ keyword.other
//                 ^^^^^ meta.binding.name variable.other.member
//                      ^ punctuation.separator.mapping.key-value
//                        ^^^^ variable.other.readwrite.js
//                            ^ punctuation.accessor.js
//                             ^^^^^^^^^^ meta.property.object.js
//                                       ^ punctuation.accessor.js
//                                        ^^^^^^^^ meta.property.object.js
    default property list<QtObject> data
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^ keyword.other.qml storage.modifier.default.qml
//          ^^^^^^^^ keyword.declaration
//                                  ^^^^ meta.binding.name variable.other.member
    default property alias mainItem: control.contentItem
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^ keyword.other.qml storage.modifier.default.qml
//          ^^^^^^^^ keyword.declaration
//                   ^^^^^ keyword.other
//                                 ^ punctuation.separator.mapping.key-value
    readonly property string name: "xyz"
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^^ keyword.other.qml storage.modifier.required.qml
//           ^^^^^^^^ keyword.declaration
//                           ^^^^ meta.binding.name variable.other.member
//                               ^ punctuation.separator.mapping.key-value.qml
//                                 ^^^^^ meta.string string.quoted.double
    property url icon: Qt.application.layoutDirection === Qt.RightToLeft
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.block.qml meta.binding.property.qml
//  ^^^^^^^^ keyword.declaration
//           ^^^ support.type
//               ^^^^ meta.binding.name variable.other.member
//                   ^ punctuation.separator.mapping.key-value.qml
//                     ^^ support.class.builtin.qml
//                       ^ punctuation.accessor.js
//                        ^^^^^^^^^^^ support.type.object.qt.qml support.class.builtin.qml
//                                   ^ punctuation.accessor.js
//                                    ^^^^^^^^^^^^^^^ support.type.object.application.qml
//                                                    ^^^ keyword.operator.comparison.js
//                                                        ^^ support.class.builtin.qml
//                                                          ^ punctuation.accessor.js
//                                                           ^^^^^^^^^^^ support.constant.builtin.qml
        ? "go-back-rtl" : "go-back"
//      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//      ^ keyword.operator.ternary
//        ^^^^^^^^^^^^^ meta.string string.quoted.double
//                      ^ keyword.operator.ternary
//                        ^^^^^^^^^ meta.string string.quoted.double
    property int size: if (cond) { return 1; }
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^^ keyword.declaration
//           ^^^ support.type
//               ^^^^ meta.binding.name variable.other.member
//                   ^ punctuation.separator.mapping.key-value
//                     ^^ meta.conditional.js keyword.control.conditional.if.js
//                        ^^^^^^ meta.conditional.js meta.group.js
//                               ^^^^^^^^^^^^^ meta.conditional.js meta.block.js
//                                 ^^^^^^ keyword.control.flow.return.js
//                                         ^ punctuation.terminator.statement.js
    else if { return 2; } else {}
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml meta.conditional.js
//  ^^^^^^^ keyword.control.conditional.elseif.js
//          ^^^^^^^^^^^^^ meta.block.js
//                        ^^^^ keyword.control.conditional.else.js
//                             ^^ meta.block.js
    property point mouse:
//  ^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^^ keyword.declaration
//           ^^^^^ support.type
//                 ^^^^^ meta.binding.name variable.other.member
        Qt.point(null, undefined, NaN)
//      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//      ^^ support.class.builtin.qml
//        ^ punctuation.accessor.js
//         ^^^^ support.function.builtin.qml
//               ^^^^ meta.group.js constant.language.null.js
//                     ^^^^^^^^^ meta.group.js constant.language.undefined.js
//                                ^^^ meta.group.js constant.language.nan.js
}
// <- meta.block punctuation.section.block.end
// ^ - meta.block
Item {property}
//   ^^^^^^^^^^ meta.block
//             ^ - meta.block
Item {property int}
//   ^^^^^^^^^^^^^^ meta.block
//                 ^ - meta.block

Properties {
    x: 42
//  ^^^^^^ meta.binding.property
//  ^ meta.binding.name
//   ^ punctuation.separator.mapping.key-value
//     ^^ meta.number.integer.decimal.js constant.numeric.value.js
    y: 42;
//       ^ meta.binding.property punctuation.terminator.statement.js
//        ^ - meta.binding.property
    z;
//  ^^ meta.binding.property
//  ^ meta.binding.name
//   ^ punctuation.terminator.statement.qml - invalid.illegal.unexpected-terminator
    property: "color"
//  ^^^^^^^^^^^^^^^^^^ meta.binding.property
//  ^^^^^^^^ meta.binding.name - variable.other.member
//          ^ punctuation.separator.mapping.key-value
//            ^^^^^^^ meta.string.qml
    component: myDelegate
//  ^^^^^^^^^^^^^^^^^^^^^ meta.binding.property
//  ^^^^^^^^^ meta.binding.name - keyword.declaration.component
//           ^ punctuation.separator.mapping.key-value
//             ^^^^^^^^^^ variable.other.readwrite.js
    implicitHeight: implicitContentHeight
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^^^^^^^^ meta.binding.name - variable.other.member
//                ^ punctuation.separator.mapping.key-value
//                  ^^^^^^^^^^^^^^^^^^^^^ variable.other.readwrite.js
        + header.height + footer.height;;
//      ^ keyword.operator.arithmetic.js
//                      ^ keyword.operator.arithmetic.js
//                                     ^ punctuation.terminator.statement.js
//                                      ^ invalid.illegal.unexpected-terminator
}

WithMethods {
    id: withMethods
    function abc(arg1) {}
//  ^^^^^^^^ meta.function keyword.declaration.function
//           ^^^ meta.function entity.name.function
//              ^ meta.function.parameters punctuation.section.group.begin
//               ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                   ^ meta.function.parameters punctuation.section.group.end
//                     ^^ meta.function meta.block
//                       ^ meta.block.qml - meta.function
// make sure statements still work
    required property rect rect
//  ^^^^^^^^ keyword.other storage.modifier.required
//           ^^^^^^^^ keyword.declaration
//                    ^^^^ support.type
//                         ^^^^ meta.binding.name variable.other.member
    function def(arg2, arg3) {
        const i = 42;
//      ^^^^^ meta.block.qml meta.function meta.block keyword.declaration
//                ^^ meta.block.qml meta.function.js meta.block.js meta.number.integer.decimal.js constant.numeric.value.js
        function () {};
//      ^^^^^^^^ meta.block.qml meta.function meta.block.js meta.function keyword.declaration.function
    }
    function typed(arg4: string, arg5: Item, arg6: QtQuick.Item, { objectName }) {
//                 ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                     ^ meta.function.parameters punctuation.separator.type
//                       ^^^^^^ meta.function.parameters support.type
//                             ^ meta.function.parameters punctuation.separator.parameter.function
//                               ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                                   ^ meta.function.parameters punctuation.separator.type
//                                     ^^^^ meta.function.parameters support.class
//                                         ^ meta.function.parameters punctuation.separator.parameter.function
//                                           ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                                               ^ meta.function.parameters punctuation.separator.type
//                                                 ^^^^^^^ meta.function.parameters support.class
//                                                        ^ meta.function.parameters punctuation.accessor
//                                                         ^^^^ meta.function.parameters support.class
//                                                             ^ meta.function.parameters punctuation.separator.parameter.function
//                                                                 ^^^^^^^^^^ meta.function.parameters meta.binding.destructuring.mapping meta.mapping.key meta.binding.name variable.parameter.function
        let j = 9001;
//      ^^^ meta.block.qml meta.function.js meta.block.js keyword.declaration.js
    }
    function returns(): string {let i;}
//                    ^ meta.function.js punctuation.separator.type.qml
//                      ^^^^^^ meta.function.js support.type
//                             ^^^^^^^^ meta.block.qml meta.function.js meta.block.js
//                              ^^^ keyword.declaration.js
    function returns(): void   {let i;}
//  ^^^^^^^^ keyword.declaration.function.js
//                    ^ meta.function.js punctuation.separator.type.qml
//                      ^^^^ meta.function.js support.type.void.js
//                             ^^^^^^^^ meta.block.qml meta.function.js meta.block.js
//                              ^^^ keyword.declaration.js
    function returns(): other  {let i;}
//  ^^^^^^^^ keyword.declaration.function.js
//                    ^ meta.function.js punctuation.separator.type.qml
//                      ^^^^ meta.function.js meta.type.qml
//                             ^^^^^^^^ meta.block.qml meta.function.js meta.block.js
//                              ^^^ keyword.declaration.js
    function returns():        {let i;}
//  ^^^^^^^^ keyword.declaration.function.js
//                    ^ meta.function.js punctuation.separator.type.qml
//                             ^^^^^^^^ meta.block.qml meta.function.js meta.block.js
//                              ^^^ keyword.declaration.js
}

Signals {
    signal basic1;
//  ^^^^^^ meta.function keyword.declaration.function
//         ^^^^^^ meta.function entity.name.function
//               ^ meta.function punctuation.terminator.statement
    signal basic2
//  ^^^^^^ meta.function keyword.declaration.function
//         ^^^^^^ meta.function entity.name.function
    signal decorated1();
//  ^^^^^^ meta.function keyword.declaration.function
//         ^^^^^^^^^^ meta.function entity.name.function
//                   ^ meta.function.parameters punctuation.section.group.begin
//                    ^ meta.function.parameters punctuation.section.group.end
//                     ^ meta.function punctuation.terminator.statement
    signal decorated2()
//  ^^^^^^ meta.function keyword.declaration.function
//         ^^^^^^^^^^ meta.function entity.name.function
//                   ^ meta.function.parameters punctuation.section.group.begin
//                    ^ meta.function.parameters punctuation.section.group.end
    signal untyped(arg1, arg2: string, arg3)
//  ^^^^^^ meta.function keyword.declaration.function
//         ^^^^^^^ meta.function entity.name.function
//                ^ meta.function.parameters punctuation.section.group.begin
//                 ^^^^ invalid.illegal.expected-type
//                     ^ meta.function.parameters punctuation.separator.parameter.function
//                       ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                           ^ meta.function.parameters punctuation.separator.type
//                             ^^^^^^ meta.function.parameters support.type
//                                   ^ meta.function.parameters punctuation.separator.parameter.function
//                                     ^^^^ invalid.illegal.expected-type
//                                         ^ meta.function.parameters punctuation.section.group.end
    signal pressed(arg1: real, arg2: QQC2.Button)
//  ^^^^^^ meta.function keyword.declaration.function
//         ^^^^^^^ meta.function entity.name.function
//                ^ meta.function.parameters punctuation.section.group.begin
//                 ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                     ^ meta.function.parameters punctuation.separator.type
//                       ^^^^ meta.function.parameters support.type
//                           ^ meta.function.parameters punctuation.separator.parameter.function
//                             ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                                 ^ meta.function.parameters punctuation.separator.type
//                                   ^^^^ meta.function.parameters support.class
//                                       ^ meta.function.parameters punctuation.accessor
//                                        ^^^^^^ meta.function.parameters support.class
//                                              ^ meta.function.parameters punctuation.section.group.end
    signal clicked(point arg1, size arg2)
//  ^^^^^^ meta.function keyword.declaration.function
//         ^^^^^^^ meta.function entity.name.function
//                ^ meta.function.parameters punctuation.section.group.begin
//                 ^^^^^ meta.function.parameters support.type
//                       ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                           ^ meta.function.parameters punctuation.separator.parameter.function
//                             ^^^^ meta.function.parameters support.type
//                                  ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                                      ^ meta.function.parameters punctuation.section.group.end
    signal hovered(Item arg1, QQC2.Button arg2)
//  ^^^^^^ meta.function keyword.declaration.function
//         ^^^^^^^ meta.function entity.name.function
//                ^ meta.function.parameters punctuation.section.group.begin
//                 ^^^^ meta.function.parameters support.class
//                      ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                          ^ meta.function.parameters punctuation.separator.parameter.function
//                            ^^^^ meta.function.parameters support.class
//                                ^ meta.function.parameters punctuation.accessor
//                                 ^^^^^^ meta.function.parameters support.class
//                                        ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                                            ^ meta.function.parameters punctuation.section.group.end
    signal mixed(url arg1, arg2: bool)
//  ^^^^^^ meta.function keyword.declaration.function
//         ^^^^^ meta.function entity.name.function
//              ^ meta.function.parameters punctuation.section.group.begin
//               ^^^ meta.function.parameters support.type
//                   ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                       ^ meta.function.parameters punctuation.separator.parameter.function
//                         ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                             ^ meta.function.parameters punctuation.separator.type
//                               ^^^^ meta.function.parameters support.type
//                                   ^ meta.function.parameters punctuation.section.group.end
    signal multiline(url one,
//                   ^^^ meta.function.parameters support.type
//                       ^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                          ^ meta.function.parameters punctuation.separator.parameter.function
        two   ,
//      ^^^ meta.function.parameters invalid.illegal.expected-type.qml meta.binding.name.js variable.parameter.function.js
//         ^^^^^ - invalid.illegal
//            ^ meta.function.parameters punctuation.separator.parameter.function
        string three url four,
//      ^^^^^^^^^^^^^^^^^^^^^^ meta.function.parameters - invalid.illegal
//      ^^^^^^ support.type
//             ^^^^^ meta.binding.name variable.parameter.function
//                   ^^^ support.type
//                       ^^^^ meta.binding.name variable.parameter.function
//                           ^ punctuation.separator.parameter.function
        five,
//      ^^^^^^ meta.function.parameters
//      ^^^^ invalid.illegal.expected-type.qml meta.binding.name.js variable.parameter.function.js
//          ^ punctuation.separator.parameter.function
//          ^^ - invalid.illegal
        six/**/:/**/ var/**/,
//      ^^^^^^^^^^^^^^^^^^^^^^ meta.function.parameters - invalid.illegal
//      ^^^ meta.binding.name variable.parameter.function
//             ^ punctuation.separator.type
//                   ^^^ support.other
//                          ^ punctuation.separator.parameter.function
        string
//      ^^^^^^ support.type
//      ^^^^^^^ meta.function.parameters - invalid.illegal
            seven,
//          ^^^^^^^ meta.function.parameters - invalid.illegal
//          ^^^^^ meta.binding.name variable.parameter.function
//               ^ punctuation.separator.parameter.function
        eight:
//      ^^^^^^^ meta.function.parameters - invalid.illegal
//      ^^^^^ meta.binding.name variable.parameter.function
//           ^ punctuation.separator.type
            url,
//          ^^^^^ meta.function.parameters - invalid.illegal
//          ^^^ support.type
//             ^ punctuation.separator.parameter.function
        nine/**/
//      ^^^^^^^^^ meta.function.parameters - invalid.illegal
//      ^^^^ meta.binding.name variable.parameter.function
//          ^^^^ comment.block
            /**/:/**/
//          ^^^^^^^^^^ meta.function.parameters - invalid.illegal
//          ^^^^ comment.block
//              ^ punctuation.separator.type
//               ^^^^ comment.block
            /**/url,
//          ^^^^^^^^^ meta.function.parameters - invalid.illegal
//          ^^^^ comment.block
//              ^^^ support.type
//                 ^ punctuation.separator.parameter.function
        url: url,
//      ^^^ meta.binding.name variable.parameter.function
//         ^ punctuation.separator.type
//           ^^^ support.type
//              ^ punctuation.separator.parameter.function
        url  url,
//      ^^^ support.type
//           ^^^ meta.binding.name variable.parameter.function
//              ^ punctuation.separator.parameter.function
    )
//  ^ meta.function.parameters punctuation.section.group.end

// <- meta.block.qml meta.function.js
    ;
//  ^ meta.function.js punctuation.terminator.statement.js
//   ^ - meta.function.js punctuation.terminator.statement.js
}

Expressions {
    function multiline_strings() {
        "use
//      ^^^^^ meta.string string.quoted.double
//      ^ punctuation.definition.string.begin
//          ^ invalid.deprecated.newline.qml
        strict";
//      ^^^^^^^ meta.string string.quoted.double
//            ^ punctuation.definition.string.end
//             ^ - meta.string
        const single = 'flip
//                     ^^^^^^ meta.string string.quoted.single
//                     ^ punctuation.definition.string.begin
//                          ^ invalid.deprecated.newline.qml
        flop';
//      ^^^^^ meta.string string.quoted.single
//          ^ punctuation.definition.string.end
        const template = `hip
//                       ^^^^^ meta.string string.quoted.other
//                           ^ - invalid.deprecated.newline.qml
        hop`;
    }
    function support_js() {
        ArrayWho();
//      ^^^^^^^^ meta.function-call.js variable.function.js - support.class
        Array(42);
//      ^^^^^ support.class.builtin.js
        Date.now();
//      ^^^^ support.class.builtin.js
//          ^ punctuation.accessor.js
//           ^^^ support.function.builtin.js
        const y = k * (x + b);
//      ^^^^^ keyword.declaration.js
//            ^ meta.binding.name.js variable.other.readwrite.js
//              ^ keyword.operator.assignment.js
//                ^ variable.other.readwrite.js
//                  ^ keyword.operator.arithmetic.js
//                    ^^^^^^^ meta.group.js
//                    ^ punctuation.section.group.begin.js
//                     ^ variable.other.readwrite.js
//                       ^ keyword.operator.arithmetic.js
//                         ^ variable.other.readwrite.js
//                          ^ punctuation.section.group.end.js
//                           ^ punctuation.terminator.statement.js
        window
//      ^^^^^^ - support.type
        XMLHttpRequest
//      ^^^^^^^^^^^^^^ support.class.dom.js
    }
    property real foox: (foo as Item).x
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property
//                      ^ punctuation.section
//                       ^^^ variable.other
//                           ^^ keyword.operator.qml
//                              ^^^^ support.class.builtin.qml
//                                  ^ punctuation.section
//                                   ^ punctuation.accessor.js
    function support_qmljs() {
        abc = def as X.Yz;
//          ^ keyword.operator.assignment.js
//            ^^^ variable.other.readwrite.js
//                ^^ keyword.operator.qml
//                   ^ support.class.js
//                    ^ punctuation.accessor.js
//                     ^^ meta.property.object.js
//                       ^ punctuation.terminator.statement.js
    }
    function support_qtqml() {
        Component.Ready
//                ^^^^^ support.constant.builtin.qml
        Binding.RestoreBinding
//              ^^^^^^^^^^^^^^ support.constant.builtin.qml
        Binding.RestoreBindingOr
//              ^^^^^^^^^^^^^^^^ - support.constant.builtin.qml
        Binding.RestoreBindingOrValue
//              ^^^^^^^^^^^^^^^^^^^^^ support.constant.builtin.qml
        Locale.Monday
//             ^^^^^^ support.constant.builtin.qml
        Locale.MetricSystem
//             ^^^^^^^^^^^^ support.constant.builtin.qml
        Locale.ShortFormat
//             ^^^^^^^^^^^ support.constant.builtin.qml
        Locale.DefaultNumberOptions
//             ^^^^^^^^^^^^^^^^^^^^ support.constant.builtin.qml
        Locale.DataSizeSIFormat
//             ^^^^^^^^^^^^^^^^ support.constant.builtin.qml
        print(); qsTr("abc"); QT_TR_NOOP();
//      ^^^^^ support.function.qml
//               ^^^^ support.function.qml
//                            ^^^^^^^^^^ support.function.qml
        Qt.quit();
//      ^^ support.class.builtin.qml
//        ^ punctuation.accessor.js
//         ^^^^ support.function.builtin.qml
        Qt.AlignRight | Qt.AlignVCenter | Qt.AlignBananas
//      ^^ support.class.builtin.qml
//         ^^^^^^^^^^ support.constant.builtin.qml
//                         ^^^^^^^^^^^^ support.constant.builtin.qml
//                                           ^^^^^^^^^^^^ - support.constant.builtin.qml
        Qt.ControlModifier
//         ^^^^^^^^^^^^^^^ support.constant.builtin.qml
        Qt.ShiftModifier
//         ^^^^^^^^^^^^^ support.constant.builtin.qml
        Qt.Key_F
//         ^^^^^ support.constant.builtin.qml
        Qt.Key_F12
//         ^^^^^^^ support.constant.builtin.qml
        Qt.Key_F42
//         ^^^^^^^ - support.constant.builtin.qml
        Qt.application.domain
//      ^^ support.class.builtin.qml
//         ^^^^^^^^^^^ support.type.object.qt.qml support.class.builtin.qml
//                     ^^^^^^ support.type.object.application.qml
        Qt.platform.os
//                  ^^ support.type.object.platform.qml
    }
    function support_qtquick() {
        Animation.Infinite
//      ^^^^^^^^^ support.class.builtin.qml
//                ^^^^^^^^ support.constant.builtin.qml
        DoubleValidator.StandardNotation, DoubleValidator.Invalid
//                      ^^^^^^^^^^^^^^^^ support.constant.builtin.qml
//                                                        ^^^^^^^ support.constant.builtin.qml
        Drag.Automatic, Drag.XAndYAxis
//           ^^^^^^^^^ support.constant.builtin.qml
//                           ^^^^^^^^^ support.constant.builtin.qml
        DragHandler.SnapAlways
//                  ^^^^^^^^^^ support.constant.builtin.qml
        Easing.OutQuad
//      ^^^^^^ support.class.builtin.qml
//             ^^^^^^^ support.constant.builtin.qml
        EventPoint.GrabPassive
//                 ^^^^^^^^^^^ support.constant.builtin.qml
        Flickable.FollowBoundsBehavior, Flickable.VerticalFlick
//                ^^^^^^^^^^^^^^^^^^^^ support.constant.builtin.qml
//                                                ^^^^^^^^^^^^^ support.constant.builtin.qml
        Font.Bold, FontLoader.Ready
//           ^^^^ support.constant.builtin.qml
//                            ^^^^^ support.constant.builtin.qml
        Gradient.Horizontal
//               ^^^^^^^^^^ support.constant.builtin.qml
        GraphicsInfo.Software
//                   ^^^^^^^^ support.constant.builtin.qml
        Grid.TopToBottom, Grid.AlignLeft
//           ^^^^^^^^^^^ support.constant.builtin.qml
//                             ^^^^^^^^^ support.constant.builtin.qml
        GridView.view.width, GridView.TopToBottom, GridView.NoSnap
//               ^^^^ support.class.builtin.qml
//                                    ^^^^^^^^^^^ support.constant.builtin.qml
//                                                          ^^^^^^ support.constant.builtin.qml
        Image.AlignRight, Image.Tile
//            ^^^^^^^^^^ support.constant.builtin.qml
//                              ^^^^ support.constant.builtin.qml
        InputMethod.ContextMenu
//                  ^^^^^^^^^^^ support.constant.builtin.qml
        Item.BottomRight
//           ^^^^^^^^^^^ support.constant.builtin.qml
        ItemView.ApplyRange, ItemView.OvershootBounds
//               ^^^^^^^^^^ support.constant.builtin.qml
//                                    ^^^^^^^^^^^^^^^ support.constant.builtin.qml
        KeyNavigation.BeforeItem, Keys.AfterItem
//                    ^^^^^^^^^^ support.constant.builtin.qml
//                                     ^^^^^^^^^ support.constant.builtin.qml
        ListView.Horizontal, ListView.OverlayFooter
        Loader.Ready
//             ^^^^^ support.constant.builtin.qml
        PathAnimation.LeftFirst
//                    ^^^^^ support.constant.builtin.qml
        PathArc.Clockwise
//              ^^^^^^^^^ support.constant.builtin.qml
        PathView.StrictlyEnforceRange
//               ^^^^^^^^^^^^^^^^^^^^ support.constant.builtin.qml
        Pinch.XAndYAxis
//            ^^^^^^^^^ support.constant.builtin.qml
        PointerDevice.Pen
//                    ^^^ support.constant.builtin.qml
        PointerHandler.ApprovesTakeOverByHandlersOfSameType, PointerHandler.CanTakeOverFromItems
//                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ support.constant.builtin.qml
//                                                                          ^^^^^^^^^^^^^^^^^^^^ support.constant.builtin.qml
        RotationAnimation.Shortest, RotationAnimator.Numerical
//                        ^^^^^^^^ support.constant.builtin.qml
//                                                   ^^^^^^^^^ support.constant.builtin.qml
        ShaderEffect.BackFaceCulling
//                   ^^^^^^^^^^^^^^^ support.constant.builtin.qml
        ShaderEffectSource.RGBA, ShaderEffectSource.Repeat
//                         ^^^^ support.constant.builtin.qml
//                                                  ^^^^^^ support.constant.builtin.qml
        SmoothedAnimation.Sync
//                        ^^^^ support.constant.builtin.qml
        StandardKey.Copy
//                  ^^^^ support.constant.builtin.qml
        SystemPalette.Active
//                    ^^^^^^ support.constant.builtin.qml
        TableView.OvershootBounds
//                ^^^^^^^^^^^^^^^ support.constant.builtin.qml
        TapHandler.WithinBounds
//                 ^^^^^^^^^^^^ support.constant.builtin.qml
        Text.AlignJustify, Image.AlignJustify
//           ^^^^^^^^^^^^ support.constant.builtin.qml
//                               ^^^^^^^^^^^^ - support.constant.builtin.qml
        TextEdit.SelectWords
//               ^^^^^^^^^^^ support.constant.builtin.qml
        TextInput.CursorOnCharacter
//                ^^^^^^^^^^^^^^^^^ support.constant.builtin.qml
        // V - Validators
        IntValidator.Invalid, RegExpValidator.Invalid, RegularExpressionValidator.Invalid
//                   ^^^^^^^ support.constant.builtin.qml
//                                            ^^^^^^^ support.constant.builtin.qml
//                                                                                ^^^^^^^ support.constant.builtin.qml
        ViewSection.InlineLabels, ViewSection.FirstCharacter
//                  ^^^^^^^^^^^^ support.constant.builtin.qml
//                                            ^^^^^^^^^^^^^^ support.constant.builtin.qml
    }
    function support_qtquick_dialogs() {
        StandardButton.Cancel
//                     ^^^^^^ support.constant.builtin.qml
        StandardIcon.Question
//                   ^^^^^^^^ support.constant.builtin.qml
    }
    function support_qtquick_controls() {
        AbstractButton.TextBesideIcon, Button.TextBesideIcon
//                     ^^^^^^^^^^^^^^ support.constant.builtin.qml
//                                            ^^^^^^^^^^^^^^ support.constant.builtin.qml
        Popup.Center, Popup.CloseOnEscape
//            ^^^^^^ support.constant.builtin.qml
//                          ^^^^^^^^^^^^^ support.constant.builtin.qml
        Dial.NoSnap, Dial.Circular
//           ^^^^^^ support.constant.builtin.qml
//                        ^^^^^^^^ support.constant.builtin.qml
        Dialog         .Ok, Dialog.NoAutoClose
//                      ^^ support.constant.builtin.qml
//                                 ^^^^^^^^^^^ support.constant.builtin.qml
        DialogButtonBox.Ok, DialogButtonBox.AcceptRole, DialogButtonBox.AndroidLayout
//                      ^^ support.constant.builtin.qml
//                                          ^^^^^^^^^^ support.constant.builtin.qml
//                                                                      ^^^^^^^^^^^^^ support.constant.builtin.qml
        DialogButtonBox.Header
//                      ^^^^^^ support.constant.builtin.qml
        ScrollBar.NoSnap, ScrollBar.AlwaysOff
//                ^^^^^^ support.constant.builtin.qml
//                                  ^^^^^^^^^ support.constant.builtin.qml
        Slider.NoSnap
//             ^^^^^^ support.constant.builtin.qml
        StackView.Activating
//                ^^^^^^^^^^ support.constant.builtin.qml
        TabBar.Header, ToolBar.Footer
//             ^^^^^^ support.constant.builtin.qml
//                             ^^^^^^ support.constant.builtin.qml
        TextArea.WrapAnywhere
//               ^^^^^^^^^^^^ support.constant.builtin.qml
        TextField.SelectCharacters
//                ^^^^^^^^^^^^^^^^ support.constant.builtin.qml
    }
    function support_qtquick_layouts() {
        GridLayout.TopToBottom
//                 ^^^^^^^^^^^ support.constant.builtin.qml
    }
    function support_qtquick_templates() {
        T.Button.TextBesideIcon
//               ^^^^^^^^^^^^^^ support.constant.builtin.qml
        QQC2.ScrollBar.AlwaysOff
//                     ^^^^^^^^^ support.constant.builtin.qml
    }
}

// <- - meta.block

InlineComponents {
    component A : Label {}
//  ^^^^^^^^^ keyword.declaration.component
//            ^ entity.name.class
//              ^ punctuation.separator.type
//                ^^^^^ support.class
//                      ^^ meta.block meta.block
//                      ^ punctuation.section.block.begin
//                       ^ punctuation.section.block.end
//  ^^^^^^^^^^^^^^^^^^^^^^ meta.component.qml

// <- - meta.component.qml
    component B : C.D {}
//  ^^^^^^^^^ keyword.declaration.component
//                ^ support.class
//                 ^ punctuation.accessor
//                  ^ support.class
    B {}
//  ^ support.class
    component E : F {};
//                    ^ invalid.illegal.unexpected-terminator.qml
    G {}
//  ^ support.class
}

Enums {
    enum Days {
//  ^^^^^^^^^^^^ meta.enum.qml
//       ^^^^ meta.enum.identifier.qml entity.name.enum.qml
//  ^^^^ keyword.declaration.enum.qml
        Monday, Saturday,
//      ^^^^^^^^^^^^^^^^^^ meta.enum.qml meta.block.qml meta.sequence.constants.qml
//      ^^^^^^ meta.constants.identifier.qml entity.name.constant.qml
//            ^ punctuation.separator.comma.qml
//              ^^^^^^^^ meta.constants.identifier.qml entity.name.constant.qml
        sunday, Friday
//      ^^^^^^ - meta.constants.identifier.qml & - entity.name.constant.qml
//              ^^^^^^ meta.constants.identifier.qml entity.name.constant.qml
    };
//  ^ meta.enum.qml meta.block.qml meta.sequence.constants.qml punctuation.section.block.end.qml
//   ^ - meta.enum.qml & invalid.illegal.unexpected-terminator.qml
    enum Color {
//  ^^^^^^^^^^^^ meta.enum.qml
//       ^^^^^ meta.enum.identifier.qml entity.name.enum.qml
//  ^^^^ keyword.declaration.enum.qml
        White = 0x1234,
//      ^^^^^ meta.constants.identifier.qml entity.name.constant.qml
//            ^ keyword.operator.assignment.qml
//              ^^^^^^ meta.number.integer
//                    ^ punctuation.separator.comma.qml
        Orange,
//      ^^^^^^ meta.constants.identifier.qml entity.name.constant.qml
//            ^ punctuation.separator.comma.qml
        Green = ,
//            ^ keyword.operator.assignment.qml
//              ^ punctuation.separator.comma.qml
        Red
//      ^^^ meta.constants.identifier.qml entity.name.constant.qml
    }
    enum Months
//  ^^^^^^^^^^^^ meta.enum.qml
//  ^^^^ keyword.declaration.enum.qml
    enum
//  ^^^^ - invalid.illegal.unexpected-terminator.qml
}

Handlers {
    onPressed: y = event.y;
//  ^^^^^^^^^^^^^^^^^^^^^^^ meta.handler.qml
//  ^^^^^^^^^ meta.binding.name variable.function
//    ^^^^^^^ markup.underline
//           ^ punctuation.separator.mapping.key-value
//             ^ variable.other.readwrite.js
//               ^ keyword.operator.assignment.js
//                 ^^^^^ variable.other.readwrite.js
//                      ^ punctuation.accessor.js
//                       ^ meta.property.object.js
//                        ^ punctuation.terminator.statement.js
    onWidthChanged: {
//  ^^^^^^^^^^^^^^^^^^ meta.handler.qml
//  ^^^^^^^^^^^^^^ meta.binding.name variable.function
//    ^^^^^ markup.underline
//                ^ punctuation.separator.mapping.key-value
//                  ^^ meta.block.js
        const abc = "xyz";
//      ^^^^^^^^^^^^^^^^^^ meta.handler.qml meta.block.js
//      ^^^^^ keyword.declaration.js
//                  ^^^^^ meta.string string.quoted.double
    };;
//  ^ meta.block.js
//   ^^ invalid.illegal.unexpected-terminator
    Component.onCompleted: {}
//  ^^^^^^^^^ support.class.builtin
//           ^ punctuation.accessor.js
//            ^^^^^^^^^^^^^^^ meta.handler
//            ^^^^^^^^^^^ meta.binding.name support.function markup.italic
//              ^^^^^^^^^ markup.underline
    onEntered: Animation {}
//  ^^^^^^^^^^^^^^^^^^^^^^^ meta.handler.qml
//  ^^^^^^^^^ meta.binding.name variable.function
//    ^^^^^^^ markup.underline
//             ^^^^^^^^^ support.class.qml
//                       ^^ meta.block.qml
    Connections {
//  ^^^^^^^^^^^ support.class
        target: root
//      ^^^^^^^^^^^^^ meta.block meta.block meta.binding.property
        function onPressed(event) {}
//               ^^^^^^^^^ meta.binding.name variable.function
//                 ^^^^^^^ markup.underline
//                         ^^^^^ meta.function.parameters.qml meta.binding.name.js variable.parameter.function.js
        function onWidthChanged() {}
//               ^^^^^^^^^^^^^^ meta.binding.name variable.function
//                 ^^^^^ markup.underline
    }
}

GroupedProperties {
    font.pixelSize: 42
//  ^^^^^^^^^^^^^^^^^^^ meta.binding.property
//       ^^^^^^^^^^^^^^ - meta.binding.property meta.binding.property
//  ^^^^ meta.binding.name
//      ^ punctuation.accessor
//       ^^^^^^^^^ meta.binding.name
//                ^ punctuation.separator.mapping.key-value
//                  ^^ meta.number.integer.decimal.js constant.numeric.value.js
    x.y.z: 42;;
//  ^^^^^^^^^^ meta.binding.property
//  ^^^^^^^^^^ - meta.binding.property meta.binding.property
//           ^ punctuation.terminator.statement.js - invalid.illegal
//            ^ invalid.illegal.unexpected-terminator.qml
    anchors {
//  ^^^^^^^^^^ meta.binding.property
//          ^ meta.binding.property meta.block punctuation.section.block.begin
        left: parent.left
//      ^^^^^^^^^^^^^^^^^^ meta.binding.property meta.block meta.binding.property
        right: undefined
//      ^^^^^^^^^^^^^^^^^ meta.binding.property meta.block meta.binding.property
//      ^^^^^ meta.binding.name
//           ^ punctuation.separator.mapping.key-value
//             ^^^^^^^^^ constant.language.undefined.js

// This is weird and illegal, but should work in editor
        onError: {}
//      ^^^^^^^^^^^ meta.binding.property meta.block meta.handler
//      ^^^^^^^ meta.binding.name variable.function
//             ^ punctuation.separator.mapping.key-value
        Item {}
//      ^^^^ meta.binding.property meta.block support.class
    }
//  ^ meta.binding.property meta.block punctuation.section.block.end
    border { size {
//           ^^^^^^^ meta.binding.property meta.block meta.binding.property
//           ^^^^ meta.binding.name
            width: NaN
//          ^^^^^^^^^^^ meta.binding.property meta.block meta.binding.property meta.block meta.binding.property
//          ^^^^^ meta.binding.name
//               ^ punctuation.separator.mapping.key-value
//                 ^^^ constant.language.nan.js
    } }
//  ^ meta.block meta.binding.property meta.block meta.binding.property meta.block punctuation.section.block.end
//     ^ meta.block - meta.binding.property
}

AttachedProperties {
    Layout.fillWidth: true
//  ^^^^^^ support.class
//        ^ punctuation.accessor
//         ^^^^^^^^^ meta.binding.name
//                  ^ punctuation.separator.mapping.key-value
//                    ^^^^ constant.language.boolean.true.js
//         ^^^^^^^^^^^^^^^^ meta.binding.property
    T.ScrollBar.vertical.policy: T.ScrollBar.AlwaysOff
//  ^ support.class
//   ^ punctuation.accessor
//    ^^^^^^^^^ support.class
//             ^ punctuation.accessor
//              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property
//              ^^^^^^^^ meta.binding.name
//                      ^ punctuation.accessor
//                       ^^^^^^ meta.binding.name
//                             ^ punctuation.separator.mapping.key-value
//                               ^ support.class.builtin
//                                ^ punctuation.accessor.js
//                                 ^^^^^^^^^ support.class.builtin
//                                          ^ punctuation.accessor.js
//                                           ^^^^^^^^^ support.constant.builtin
    Component.onCompleted: print(42)
//  ^^^^^^^^^ support.class.builtin
//           ^ punctuation.accessor.js
//            ^^^^^^^^^^^^^^^^^^^^^^^ meta.handler
//            ^^^^^^^^^^^ meta.binding.name support.function markup.italic
//              ^^^^^^^^^ markup.underline
//                       ^ punctuation.separator.mapping.key-value
//                         ^^^^^ support.function

// It wouldn't work (at least didn't for me), but it's perfectly legit
    Window.window.onWidthChanged: 42;
//         ^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property
//                ^^^^^^^^^^^^^^^^^^^ meta.handler.qml
//  ^^^^^^ support.class
//        ^ punctuation.accessor
//         ^^^^^^ meta.binding.name
//               ^ punctuation.accessor
//                ^^^^^^^^^^^^^^ meta.binding.name variable.function
//                  ^^^^^ markup.underline.qml
//                              ^ punctuation.separator.mapping.key-value
//                                ^^ meta.number.integer.decimal.js constant.numeric.value.js
//                                  ^ punctuation.terminator.statement.js
//                                   ^ - meta.handler.qml & - meta.binding.property
}

ObjectsAsProperties {
    delegate: Item { required property string modelData }
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.block meta.binding.property
//  ^^^^^^^^ meta.binding.name
//          ^ punctuation.separator.mapping.key-value
//            ^^^^ support.class
//                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.block meta.binding.property meta.block
//                 ^ punctuation.section.block.begin
//                   ^^^^^^^^ meta.binding.property.qml keyword.other.qml storage.modifier.required.qml
//                                                      ^ punctuation.section.block.end.qml
//                                                       ^ - meta.block meta.block
    empty: []
//         ^^ meta.sequence.js - meta.sequence.qml
    actions: [Action {}]
//           ^^^^^^^^^^^ meta.binding.property meta.sequence
//                      ^ - meta.binding.property & - meta.sequence
//            ^^^^^^ support.class.qml
//                   ^^ meta.block.qml meta.block.qml
//                   ^ punctuation.section.block.begin
//                    ^ punctuation.section.block.end
    actions: [Action {name: "cut"}, Action {name: "copy"},, Action {name: "paste"}]
//           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.sequence.qml
//            ^^^^^^ support.class
//                                ^ punctuation.separator.comma.qml
//                                  ^^^^^^ support.class
//                                                       ^^ punctuation.separator.comma.qml
//                                                          ^^^^^^ support.class
    signals: Signals {
//                   ^^ meta.block.qml meta.binding.property.qml meta.block.qml
        onFired: {}
//      ^^^^^^^ meta.handler.qml meta.binding.name.qml variable.function.qml
        Component.onCompleted: {}
//      ^^^^^^^^^ support.class.builtin.qml
//                ^^^^^^^^^^^ meta.handler.qml meta.binding.name.qml support.function.qml markup.italic.qml
    }
    incomplete: [
    A {}, B, C {}, someId, D {} ]
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml meta.sequence.qml
//        ^ support.class
//         ^ punctuation.separator.comma.qml
//           ^ support.class
//               ^ punctuation.separator.comma.qml
//                 ^^^^^^ invalid.illegal.expected-object.qml variable.other.readwrite.js
//                       ^ punctuation.separator.comma.qml
//                         ^ support.class
    strings: ["a", "b", "c"]
//  ^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property
//  ^^^^^^^ meta.binding.name.qml
//         ^ punctuation.separator.mapping.key-value.qml
//           ^^^^^^^^^^^^^^^ meta.sequence.js - invalid.illegal.expected-object
//            ^^^ meta.string.qml
//               ^ punctuation.separator.comma.js
    methods: [
        QtObject {
            function method() {}
//          ^^^^^^^^ meta.sequence.qml meta.block.qml meta.function.js keyword.declaration.function.js
//                   ^^^^^^ meta.function.js entity.name.function.js
        }
    ]
}

@Annotation1 {}
// <- meta.annotation.qml punctuation.definition.annotation.qml
// ^^^^^^^^^ support.class.qml
//           ^^ meta.block
@Annotation2 {
// <- meta.annotation.qml punctuation.definition.annotation.qml
// ^^^^^^^^^ support.class.qml
//           ^ meta.block punctuation.section.block.begin
    signal member
//  ^^^^^^ meta.block.qml meta.function.js keyword.declaration.function.qml
//         ^^^^^^ meta.block.qml meta.function.js entity.name.function.js
}
Annotations {
    @AnnotateProp { one.two: 3 }
//  ^ meta.annotation.qml punctuation.definition.annotation.qml
    property int x: 5
//  ^^^^^^^^ meta.binding.property.qml keyword.declaration.qml
}

// <- - meta.block
