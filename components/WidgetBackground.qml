import QtQuick
import QtQuick.Layouts

import qs.globals

Rectangle {
    id: root

    radius: 5
    color: Colors.bgModule

    property int padding: 12

    Layout.preferredHeight: parent.height - padding
    Layout.preferredWidth: childrenRect.width + padding

    default property Item contentItem

    onContentItemChanged: {
        if (contentItem) {
            contentItem.parent = root
            
            contentItem.anchors.centerIn = root
        }
    }
}
