import Quickshell.Io
import QtQuick

import qs.components

ModuleText {
    id: root

    property var label: "Custom Module"

    property var icon: "? "
    property var scriptPath: ""
    property var interval: 60000

    text: icon + label

    Process {
        id: runScript

        running: true
        command: [ "sh", "-c", root.scriptPath ]
        stdout: StdioCollector {
            onStreamFinished: {
                root.label = this.text
            }
        }
    }

    Timer {
        interval: root.interval
        repeat: true

        onTriggered: {
            runScript.running = true
        }
    }
}
