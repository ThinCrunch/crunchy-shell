pragma Singleton

import Quickshell.Io
import Quickshell

// Rewrite this once Quickshell.Networking is released to the stable branch

Singleton {
    id: root

    property string device: "DEVICE"
    property string connection: "CONNECTION"
    property string type: "TYPE"

    Process {
        id: getConnectionInfo

        running: true
        command: [ "nmcli", "-t", "device", "status" ]
        stdout: StdioCollector {
            onStreamFinished: {
                var rows = this.text.split("\n")

                var finalConnection = ""
                var finalType = ""
                var finalDevice = ""
                for (const row of rows) {
                    var splitData = row.split(":")
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
                root.type = finalType
            } 
        }
    }

    Process {
        id: connectionChangeListener

        running: true
        command: ["nmcli", "monitor"]
        stdout: SplitParser {
            onRead: data=> {
                if (data.includes("primary connection")) {
                    getConnectionInfo.running = true
                }
            }
        }
    }
}

