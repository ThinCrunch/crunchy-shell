import QtQuick
import QtQuick.Layouts

import qs.components
import qs.globals
import qs.services

RowLayout {
    Repeater {
        model: HyprlandService.workspaceAmount

        ModuleText {
            id: wsLabel
            required property int index

            visible: HyprlandService.doesWorkspaceExist(index)
            color: HyprlandService.isWorkspaceFocused(index) ? Colors.fgSelected : Colors.fg

            property var icons: [ " ", "󰖟 ", "󰆣 ", " ", " " ]
            text: index < icons.length ? icons[index] : index + 1

            MouseArea {
                anchors.fill: parent
                onClicked: { HyprlandService.activateWorkspace(wsLabel.index); }
            }
        }
    }
}
