import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    radius: 5
    color: "#33ffffff"

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
