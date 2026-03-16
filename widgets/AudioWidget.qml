import Quickshell.Services.Pipewire
import QtQuick

import qs.globals

Text {
    id: root

    property var defaultAudioSink: Pipewire.defaultAudioSink
    PwObjectTracker {
        objects: [ root.defaultAudioSink ]
    }

    property int audioVolume: Math.round(defaultAudioSink.audio.volume * 100)

    font.family: Style.fontFamily
    font.pixelSize: Style.fontPixelSize
    color: Colors.fg

    text: "  " + audioVolume

    states: [
        State {
            name: "muted"
            PropertyChanges { root.color: Colors.alertHigh }
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
