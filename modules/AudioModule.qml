import Quickshell.Services.Pipewire
import QtQuick

import qs.globals

Text {
    id: root

    property var defaultAudioSink: Pipewire.defaultAudioSink
    PwObjectTracker {
        objects: [ root.defaultAudioSink ]
    }

    property int audioVolume: defaultAudioSink ? Math.round(defaultAudioSink.audio.volume * 100) : -1

    font.family: Style.fontFamily
    font.pixelSize: Style.fontPixelSize
    color: Colors.fg

    property var icon: "? "
    property var label: "AUDIO"

    text: icon + " " + label

    state: defaultAudioSink.audio.muted ? "muted" : "not-muted"
    states: [
        State {
            name: "not-muted"
            PropertyChanges { root.color: Colors.fg }
            PropertyChanges { root.icon: " " }  // TODO: Unique icon by device type
            PropertyChanges { root.label: root.audioVolume }
        },
        State {
            name: "muted"
            PropertyChanges { root.color: Colors.alertHigh }
            PropertyChanges { root.icon: " " }
            PropertyChanges { root.label: "muted" }
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
