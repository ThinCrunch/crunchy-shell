import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

RowLayout {
    spacing: 6

    Repeater {
        model: SystemTray.items

        IconImage {
            id: trayIcon

            required property var modelData
            width: 16
            height: 16

            source: modelData.icon

            clip: true
        }
    }
}
