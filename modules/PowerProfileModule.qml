import Quickshell.Services.UPower
import QtQuick

import qs.components
import qs.globals
import qs.services

Text {
    id: root

    text: "? "

    state: BatteryService.powerProfile.toString()

    states: [
        State {
            name: PowerProfile.PowerSaver.toString()
            PropertyChanges {
                root.color: Colors.fg
                root.text: " "
            }
        },
        State {
            name: PowerProfile.Balanced.toString()
            PropertyChanges {
                root.color: Colors.alertMedium
                root.text: "󰗑 "
            }
        },
        State {
            name: PowerProfile.Performance.toString()
            PropertyChanges {
                root.color: Colors.alertHigh
                root.text: " "
            }
        }
    ]

    MouseArea {
        anchors.fill: parent

        onClicked: {
            BatteryService.nextPowerProfile()
        }
    }
}
