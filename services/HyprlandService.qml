pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: root

    property string keymap: "KEYMAP"
    property string layout: usedLayouts[activeLayoutIdx]?.layout ?? "LAYOUT"
    property string variant: usedLayouts[activeLayoutIdx]?.variant ?? "VARIANT"

    property int activeLayoutIdx: 0

    property var xkbLayoutDB: []
    property var usedLayouts: []

    property int workspaceAmount: Hyprland.workspaces.values.length

    function activateWorkspace(index: int): void {
        if (isWorkspaceFocused(index)) {
            return;
        }
        _getWorkspaceByIndex(index).activate();
    }

    function doesWorkspaceExist(index: int): bool {
        const workspace = _getWorkspaceByIndex(index);
        return workspace != null;
    }

    function isWorkspaceFocused(index: int): bool {
        return Hyprland.focusedWorkspace?.id == (index + 1);
    }

    function setActiveLayout(index: int): void {
        setActiveLayout.requestedLayoutIdx = index;
        setActiveLayout.running = true;
    }

    function _getWorkspaceByIndex(index: int): HyprlandWorkspace {
        const idk = Hyprland.workspaces.values.find(w => w.id == index + 1);
        return idk;
    }

    function _getLayoutDescription(layout: string, variant: string): string {
        for (let layoutVariant of root.xkbLayoutDB) {
            if (layoutVariant["layout"] == layout && layoutVariant["variant"] == variant) {
                return layoutVariant["description"];
            }
        }

        return "No description found.";
    }

    Connections {
        target: Hyprland

        function onRawEvent(event) {
            if (event.name == "activelayout") {
                getUsedLayouts.running = true;
            }
        }
    }

    Process {
        id: getUsedLayouts

        running: false
        command: [ "hyprctl", "-j", "devices" ]
        stdout: StdioCollector {
            onStreamFinished: {
                const devices = JSON.parse(this.text);
                const mainKb = devices.keyboards.find((kb) => kb.main == true);

                let layouts = mainKb.layout.split(", ");
                let variants = mainKb.variant.split(", ");

                root.activeLayoutIdx = mainKb.active_layout_index;
                root.keymap = mainKb.active_keymap.slice(0,2).toLowerCase();

                root.usedLayouts.length = 0;
                for (let i = 0; i < layouts.length; i++) {
                    let description = root._getLayoutDescription(layouts[i], variants[i]);
                    let keymap = description.slice(0,2).toLowerCase();
                    root.usedLayouts.push({
                        idx: i,
                        layout: layouts[i],
                        variant: variants[i],
                        description: description,
                        keymap: keymap});
                }
                root.usedLayoutsChanged();
            }
        }
    }

    Process {
        id: getXkbLayoutDB

        running: true
        command: [ "sh", "-c", "xkbcli list | yq" ]
        stdout: StdioCollector {
            onStreamFinished: {
                const data = JSON.parse(this.text);
                root.xkbLayoutDB = data.layouts;

                getUsedLayouts.running = true;
            }
        }
    }

    Process {
        id: setActiveLayout

        property int requestedLayoutIdx: 0

        command: [ "hyprctl", "switchxkblayout", "current", requestedLayoutIdx ]
    }
}
