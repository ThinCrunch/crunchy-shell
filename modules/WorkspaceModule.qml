import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.globals

RowLayout {
    Repeater {
        model: Hyprland.workspaces.values.length

        ModuleText {
            required property int index

            property var workspace: Hyprland.workspaces.values.find(w => w.id == index + 1)
            visible: workspace != null

            property bool isFocused: Hyprland.focusedWorkspace?.id == (index + 1)
            color: isFocused ? Colors.fgSelected : Colors.fg

            property var icons: [ " ", "󰖟 ", "󰆣 ", " ", " " ]
            text: index < icons.length ? icons[index] : index + 1

            MouseArea {
                anchors.fill: parent
                onClicked: { parent.workspace.activate() }
            }
        }
    }
}
