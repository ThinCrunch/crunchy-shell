import Quickshell.Services.UPower
import QtQuick

import qs.globals

Text {
    id: root

    font.family: Style.fontFamily
    font.pixelSize: Style.fontPixelSize
    color: Colors.fg

    text: "? "

    state: PowerProfiles.profile.toString()

    states: [
        State {
            name: PowerProfile.PowerSaver.toString()
            PropertyChanges {
                root.color: Colors.fg;
                root.text: " "; 
            }
        },
        State {
            name: PowerProfile.Balanced.toString()
            PropertyChanges {
                root.color: Colors.alertMedium;
                root.text: "󰗑 ";
            }
        },
        State {
            name: PowerProfile.Performance.toString()
            PropertyChanges {
                root.color: Colors.alertHigh;
                root.text: " ";
            }
        }
    ]

    MouseArea {
        anchors.fill: parent

        onClicked: {
            const profileAmount = Object.keys(PowerProfile).length
            PowerProfiles.profile = (PowerProfiles.profile + 1) % profileAmount
        }
    }
}
