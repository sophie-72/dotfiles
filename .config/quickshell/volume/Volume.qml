import QtQuick
import Quickshell.Services.Pipewire
import Quickshell.Io
import qs

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

    Rectangle {
        id: iconCircle
        width: item.iconSize
        height: item.iconSize
        color: "transparent"

        Icon {
            color: Theme.get.goldColor
            size: 24
            iconName: item.iconName
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: iconCircle
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            Process {
                id: volumeControl

                running: false
                command: ["pavucontrol"]
            }

            onClicked: function (mouse) {
                if (mouse.button == Qt.LeftButton) {
                    // Left click: toggle mute
                    if (item.defaultAudioSink && item.defaultAudioSink.audio) {
                        item.defaultAudioSink.audio.muted = !item.defaultAudioSink.audio.muted;
                    }
                } else if (mouse.button == Qt.RightButton && !volumeControl.running) {
                    // Right click: open system volume control
                    volumeControl.running = true;
                }
            }

            onWheel: function (wheel) {
                // Scroll wheel: adjust volume
                if (item.defaultAudioSink && item.defaultAudioSink.audio) {
                    var delta = wheel.angleDelta.y > 0 ? 0.05 : -0.05; // 5% steps
                    var newVolume = Math.max(0, Math.min(1, item.defaultAudioSink.audio.volume + delta));
                    item.defaultAudioSink.audio.volume = newVolume;
                }
            }
        }
    }
}
