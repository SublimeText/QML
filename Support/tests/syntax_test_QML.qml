// SYNTAX TEST "Packages/Sublime-QML/Support/QML.sublime-syntax"
import QtQml
// <- source.qml meta.import.qml keyword.control.import.qml
//     ^^^^^ meta.generic-name.qml

import QtQuick.Layouts 2.15
// <- meta.import.qml keyword.control.import.qml
//     ^^^^^^^         meta.import.qml meta.qualified-name.qml meta.generic-name.qml
//            ^        meta.import.qml punctuation.accessor.dot.qml
//             ^^^^^^^ meta.import.qml meta.qualified-name.qml meta.generic-name.qml
//                     ^ constant.numeric.qml
//                      ^ punctuation.separator
//                       ^^ constant.numeric.qml

import org.kde.kirigami 2.20 as Kirigami
//                           ^^ keyword.control.import.as.qml
//                              ^^^^^^^^ meta.generic-name.qml

import ":/components"
//     ^^^^^^^^^^^^^^ meta.string.js string.quoted.double.js

// Make sure import aliases work with strings
import "./logic.js" as Logic
//                  ^^ meta.import.qml meta.import.alias.qml keyword.control.import.as.qml
