import QtQuick
import Quickshell.Services.Pipewire

Item {
    id: item

    property var defaultAudioSink: Pipewire.defaultAudioSink
    property int volume: defaultAudioSink && defaultAudioSink.audio ? Math.round(defaultAudioSink.audio.volume * 100) : 0
    property bool volumeMuted: defaultAudioSink && defaultAudioSink.audio ? defaultAudioSink.audio.muted : false

    readonly property int iconSize: 22
    readonly property int pillHeight: 22
    readonly property int pillPaddingHorizontal: 14
    readonly property int pillOverlap: iconSize / 2

    property int maxPillWidth: 0
    property bool shouldShowOsd: false
    property bool suppressVolumeChange: true

    property string iconName: {
        if (item.volumeMuted) {
            return "volume-xmark";
        } else if (item.volume > 50) {
            return "volume-high";
        } else if (item.volume > 0) {
            return "volume-low";
        } else {
            return "volume-off";
        }
    }

    width: iconSize
    height: pillHeight

    VolumeOsd {
        iconName: item.iconName
        volume: item.volume
        audioSink: item.defaultAudioSink
    }

    VolumeIndicator {
        iconSize: item.iconSize
        iconName: item.iconName
        audioSink: item.defaultAudioSink
    }
}
