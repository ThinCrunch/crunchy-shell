import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.globals
import qs.widgets

PanelWindow {
    anchors.top: true
    anchors.left: true
    anchors.right: true

    margins.top: 5
    margins.left: 200
    margins.right: 200

    implicitHeight: 32
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: Colors.bg
        radius: 5

        RowLayout {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left

            anchors.leftMargin: 8
            spacing: 8

            WidgetBackground {
                WorkspaceWidget {}
            }
        }

        RowLayout {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            WidgetBackground {
                ClockWidget {}
            }
        }

        RowLayout {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right

            anchors.rightMargin: 8

            WidgetBackground {
                KeyboardWidget {}
            }

            WidgetBackground {
                NetworkWidget {}
            }

            WidgetBackground {
                AudioWidget {}
            }
        }
    }
}
