import QtQuick
import QtQuick.Layouts

import qs.globals

Rectangle {
    id: root

    radius: Style.borderRadius
    color: Colors.bgModule

    property int padding: 12

    Layout.preferredHeight: parent.height - padding
    Layout.preferredWidth: childrenRect.width + padding

    default property Item contentItem

    onContentItemChanged: {
        if (contentItem) {
            contentItem.parent = root;
            
            contentItem.anchors.centerIn = root;
        }
    }

    signal clicked()
    signal wheel(event: WheelEvent)
    property alias containsMouse: mouseArea.containsMouse
    property alias hoverEnabled: mouseArea.hoverEnabled

    MouseArea {
        id: mouseArea

        anchors.fill: parent

        onClicked: root.clicked()
        onWheel: event => root.wheel(event)
    }
}
