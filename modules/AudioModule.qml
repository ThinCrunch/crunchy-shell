import QtQuick

import qs.components
import qs.globals
import qs.services

ModuleText {
    id: root

    property var icon: "? "
    property var label: "AUDIO"

    text: icon + " " + label

    state: AudioService.muted ? "muted" : "not-muted"
    states: [
        State {
            name: "not-muted"
            PropertyChanges {
                root.color: Colors.fg;
                root.icon: " ";  // TODO: Unique icon by device type
                root.label: AudioService.volume
            }
        },
        State {
            name: "muted"
            PropertyChanges {
                root.color: Colors.alertHigh;
                root.icon: " ";
                root.label: "muted";
            }
        }
    ]

    MouseArea {
        anchors.fill: parent

        onClicked: AudioService.toggleMute()
        onWheel: (event)=> {
            if (AudioService.muted) {
                return
            }

            if (event.angleDelta.y > 0) {
                AudioService.increaseVolume(2)
            } else {
                AudioService.decreaseVolume(2)
            }
        }
    }
}
