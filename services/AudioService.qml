pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    property var defaultAudioSink: Pipewire.defaultAudioSink
    PwObjectTracker {
        objects: [ root.defaultAudioSink ]
    }

    readonly property int volume: Math.round(defaultAudioSink?.audio?.volume * 100) ?? -1
    readonly property bool muted: defaultAudioSink.audio.muted

    function setVolume(vol: int): void {
        defaultAudioSink.audio.volume = clampVolume(vol) / 100;
    }

    function increaseVolume(vol: int): void {
        const newVolume = clampVolume(volume + vol);

        defaultAudioSink.audio.volume = newVolume / 100;
    }

    function decreaseVolume(vol: int): void {
        const newVolume = clampVolume(volume - vol);

        defaultAudioSink.audio.volume = newVolume / 100;
    }

    function toggleMute(): void {
        defaultAudioSink.audio.muted = !defaultAudioSink.audio.muted;
    }

    function clampVolume(vol: int): int {
        const clampedTop = Math.min(100, vol);
        const clamped = Math.max(0, clampedTop);

        return clamped;
    }
}
