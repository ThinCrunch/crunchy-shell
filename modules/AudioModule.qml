import Quickshell.Services.Pipewire
import QtQuick

import qs.components
import qs.globals

ModuleText {
    id: root

    property var defaultAudioSink: Pipewire.defaultAudioSink
    PwObjectTracker {
        objects: [ root.defaultAudioSink ]
    }

    property int audioVolume: defaultAudioSink ? Math.round(defaultAudioSink.audio.volume * 100) : -1

    property var icon: "? "
    property var label: "AUDIO"

    text: icon + " " + label

    state: defaultAudioSink.audio.muted ? "muted" : "not-muted"
    states: [
        State {
            name: "not-muted"
            PropertyChanges {
                root.color: Colors.fg;
                root.icon: " ";  // TODO: Unique icon by device type
                root.label: root.audioVolume 
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

        onClicked: {
            root.defaultAudioSink.audio.muted = !root.defaultAudioSink.audio.muted
        }

        onWheel: (event)=> {
            if (root.defaultAudioSink.audio.muted) {
                return
            }

            if (event.angleDelta.y > 0) {
                root.defaultAudioSink.audio.volume += 2/100
            } else {
                root.defaultAudioSink.audio.volume -= 2/100
            }
        }
    }
}
