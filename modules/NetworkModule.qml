import QtQuick

import qs.components
import qs.services

ModuleText {
    id: root

    property string icon: "?"
    property string label: "NETWORK"

    text: icon + " " + label

    state: {
        if (!NetworkService.wiredDeviceConnectionInactive) {
            return "Wired"
        }

        if (!NetworkService.wifiDeviceConnectionInactive) {
            return "Wifi"
        }

        return "NotConnected";
    }

    states: [
        State {
            name: "Wired"
            PropertyChanges {
                root.icon: "󰈁";
                root.label: NetworkService.wiredDeviceName
            }
        },
        State {
            name: "Wifi"
            PropertyChanges {
                root.icon: " ";
                root.label: NetworkService.wifiConnectedNetworkName
            }
        },
        State {
            name: "NotConnected"
            PropertyChanges {
                root.icon: " ";
                root.label: "disconnected"
            }
        }
    ]
}
