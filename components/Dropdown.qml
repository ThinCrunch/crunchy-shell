import Quickshell
import QtQuick

import qs.globals

PopupWindow {
    id: root

    color: "transparent"

    default property Item content

    property int padding: 12

    implicitHeight: content ? content.height + padding : 300
    implicitWidth: content ? content.width + padding : 300

    Rectangle {
        id: contentBg
        anchors.fill: parent

        radius: Style.borderRadius
        color: Colors.bg
    }

    onContentChanged: {
        if (content) {
            content.parent = contentBg
            content.anchors.centerIn = contentBg
        }
    }
}
