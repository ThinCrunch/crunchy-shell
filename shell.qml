import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.globals
import qs.modules

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
        radius: Style.borderRadius

        RowLayout {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left

            anchors.leftMargin: 8
            spacing: 8

            SystemTrayModule {}

            WorkspaceModule {}
        }

        RowLayout {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            ClockModule {}
        }

        RowLayout {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right

            anchors.rightMargin: 8

            KeyboardModule {}

            NetworkModule {}

            BatteryModule {}

            AudioModule {}

            PowerProfileModule {}
        }
    }
}
