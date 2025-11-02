import QtQuick
import Quickshell.Io
import qs

Rectangle {
    id: volumeIndicator

    property int iconSize
    property string iconName
    property var audioSink

    width: iconSize
    height: iconSize
    color: "transparent"

    Icon {
        color: Theme.get.goldColor
        size: 24
        iconName: volumeIndicator.iconName
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: volumeIndicator
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        Process {
            id: volumeControl

            running: false
            command: ["pavucontrol"]
        }

        onClicked: function (mouse) {
            if (mouse.button == Qt.LeftButton) {
                // Left click: toggle mute
                if (volumeIndicator.audioSink && volumeIndicator.audioSink.audio) {
                    volumeIndicator.audioSink.audio.muted = !volumeIndicator.audioSink.audio.muted;
                }
            } else if (mouse.button == Qt.RightButton && !volumeControl.running) {
                // Right click: open system volume control
                volumeControl.running = true;
            }
        }

        onWheel: function (wheel) {
            // Scroll wheel: adjust volume
            if (volumeIndicator.audioSink && volumeIndicator.audioSink.audio) {
                var delta = wheel.angleDelta.y > 0 ? 0.05 : -0.05; // 5% steps
                var newVolume = Math.max(0, Math.min(1, volumeIndicator.audioSink.audio.volume + delta));
                volumeIndicator.audioSink.audio.volume = newVolume;
            }
        }
    }
}
