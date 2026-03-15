import Quickshell
import QtQuick
import QtQuick.Layouts

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
        color: "#a6010005"
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
    }
}
