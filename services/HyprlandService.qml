pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: root

    property string keymap: "KEYMAP"
    property string layout: "LAYOUT"
    property string variant: "VARIANT"

    Connections {
        target: Hyprland

        function onRawEvent(event) {
            if (event.name == "activelayout") {
                getLayout.running = true
            }
        }
    }

    Process {
        id: getLayout

        running: true
        command: [ "hyprctl", "-j", "devices" ]
        stdout: StdioCollector {
            onStreamFinished: {
                const devices = JSON.parse(this.text)
                const mainKb = devices.keyboards.find((kb) => kb.main == true)

                const layoutIdx = mainKb.active_layout_index
                root.layout = mainKb.layout.split(", ")[layoutIdx]
                root.variant = mainKb.variant.split(", ")[layoutIdx]
                root.keymap = mainKb.active_keymap.slice(0,2).toLowerCase()
            } 
        }
    }
}
