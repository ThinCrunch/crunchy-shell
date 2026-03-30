import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.globals

PopupWindow {
    id: root

    color: "transparent"

    default property Item content

    property int padding: 12
    property bool isOpen: false
    property bool showHeader: false
    property string headerText: "?HEADER"

    property int totalSpacing: showHeader ? contentBg.spacing * 2 : 0
    property int headerHeight: showHeader ? header.height : 0
    property int contentHeight: headerHeight + content.height + totalSpacing + 2 * padding

    property int headerWidth: showHeader ? header.width : 0
    property int contentWidth: Math.max(headerWidth, content.width) + 2 * padding

    implicitHeight: content ? contentHeight : 300
    implicitWidth: content ? contentWidth : 300

    visible: false

    Rectangle {
        anchors.fill: parent

        radius: Style.borderRadius
        color: Colors.bg

        ColumnLayout {
            id: contentBg
            anchors.fill: parent
            spacing: 10

            Item {
                id: spacerTop
                implicitHeight: root.padding - contentBg.spacing
            }

            ModuleText {
                id: header
                visible: root.showHeader
                text: root.headerText

                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                font.weight: Style.fontWeight + 100
                font.pixelSize: Style.fontPixelSize + 2
            }

            Rectangle {
                id: separator
                visible: root.showHeader
                color: Colors.bgModule

                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                implicitWidth: root.contentWidth - 2 * root.padding
                implicitHeight: 2
            }

            Item {
                id: contentItem

                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.preferredWidth: root.content.width
            }

            Item {
                id: spacerBottom
                implicitHeight: root.padding - contentBg.spacing
            }
        }
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
            content.parent = contentItem
        }
    }

    onIsOpenChanged: {
        grab.active = isOpen
        root.visible = isOpen
    }
}
