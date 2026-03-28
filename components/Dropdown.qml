import Quickshell
import Quickshell.Hyprland
import QtQuick

import qs.globals

PopupWindow {
    id: root

    color: "transparent"

    default property Item content

    property int padding: 12
    property bool isOpen: false

    implicitHeight: content ? content.height + padding : 300
    implicitWidth: content ? content.width + padding : 300

    visible: false

    Rectangle {
        id: contentBg
        anchors.fill: parent

        radius: Style.borderRadius
        color: Colors.bg
    }

    HyprlandFocusGrab {
        id: grab

        active: false
        windows: [ root ]

        // Close dropdown on focus loss
        onActiveChanged: {
            if (!active) { 
                root.isOpen = false 
            }
        }
    }

    onContentChanged: {
        if (content) {
            content.parent = contentBg
            content.anchors.centerIn = contentBg
        }
    }

    onIsOpenChanged: {
        grab.active = isOpen
        root.visible = isOpen
    }
}
