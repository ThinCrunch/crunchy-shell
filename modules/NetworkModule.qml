import Quickshell.Io
import QtQuick

import qs.globals

// Rewrite this once Quickshell.Networking is released to the stable branch

Text {
    id: root

    font.family: Style.fontFamily
    font.pixelSize: Style.fontPixelSize

    property string device: ""
    property string connection: ""

    property string icon: ""
    property string label: "disconnected"

    text: icon + " " + label
    color: Colors.fg

    states: [
        State {
            name: "ethernet"
            PropertyChanges {
                root.icon: "󰈁";
                root.label: root.device }
        },
        State {
            name: "wifi"
            PropertyChanges {
                root.icon: " ";
                root.label: root.connection }
        }
    ]

    Process {
        id: getConnectionInfo

        running: true
        command: [ "nmcli", "device", "status" ]
        stdout: StdioCollector {
            onStreamFinished: {
                var rows = this.text.split("\n")

                var finalConnection = ""
                var finalType = ""
                var finalDevice = ""
                for (const row of rows) {
                    var splitData = row.trim().split(/\s+/)
                    var [device, type, state, connection] = splitData

                    if (["ethernet", "wifi"].includes(type) && state == "connected") {
                        finalDevice = device
                        finalConnection = connection
                        finalType = type

                        if (type == "ethernet") {
                            break
                        }
                    }
                }
                root.device = finalDevice
                root.connection = finalConnection
                root.state = finalType
            } 
        }
    }

    Process {
        id: connectionChangeListener

        running: true
        command: ["nmcli", "monitor"]
        stdout: SplitParser {
            onRead: data=> {
                if (data.includes("connected")) {
                    getConnectionInfo.running = true
                }
            }
        }
    }
}
