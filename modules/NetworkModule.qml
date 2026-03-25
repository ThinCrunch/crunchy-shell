import QtQuick

import qs.components
import qs.services

ModuleText {
    id: root

    property string device: NetworkService.device
    property string connection: NetworkService.connection
    property string type: NetworkService.type

    property string icon: "? "
    property string label: "NETWORK"

    text: icon + " " + label

    state: {
        switch (type) {
            case "ethernet":
                return "ethernet"
            case "wifi":
                return "wifi"
            case "":
                return "disconnected"
        }
    }

    states: [
        State {
            name: "ethernet"
            PropertyChanges {
                root.icon: "󰈁";
                root.label: root.device
            }
        },
        State {
            name: "wifi"
            PropertyChanges {
                root.icon: " ";
                root.label: root.connection
            }
        },
        State {
            name: "disconnected"
            PropertyChanges {
                root.icon: " ";
                root.label: "disconnected"
            }
        }
    ]
}

