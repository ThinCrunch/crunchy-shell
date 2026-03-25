import QtQuick

import qs.components
import qs.services

ModuleText {
    id: root

    property string device: NetworkService.device
    property string connection: NetworkService.connection

    property string icon: " "
    property string label: "disconnected"

    text: icon + " " + label

    state: NetworkService.type

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
}

