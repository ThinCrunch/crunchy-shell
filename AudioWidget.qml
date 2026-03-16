import QtQuick
import Quickshell.Services.Pipewire

Text {
    id: root

    property var defaultAudioSink: Pipewire.defaultAudioSink
    PwObjectTracker {
        objects: [ root.defaultAudioSink ]
    }

    property int audioVolume: Math.round(defaultAudioSink.audio.volume * 100)

    font.family: "FantasqueSansM Nerd Font"
    font.pixelSize: 14

    text: "  " + audioVolume
    color: "white"

    states: [
        State {
            name: "muted"
            PropertyChanges { root.color: "red" }
            PropertyChanges { root.text: "  muted" }
            PropertyChanges { target: defaultAudioSink; audio.muted: true }
        }
    ]

    MouseArea {
        anchors.fill: parent

        onClicked: {
            root.state = root.state == "" ? "muted" : ""
        }

        onWheel: (event)=> {
            if (event.angleDelta.y > 0) {
                root.defaultAudioSink.audio.volume += 2/100
            } else {
                root.defaultAudioSink.audio.volume -= 2/100
            }
        }
    }
}
