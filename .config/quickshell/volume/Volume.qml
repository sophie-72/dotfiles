import QtQuick
import QtQuick.Layouts
import Quickshell
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

    PwObjectTracker {
        objects: [item.defaultAudioSink]
    }

    Connections {
        id: connections

        function onVolumeChanged() {
            if (item.suppressVolumeChange) {
                item.suppressVolumeChange = false;
            } else {
                item.shouldShowOsd = true;
                hideTimer.restart();
            }
        }
    }

    Timer {
        id: sinkCheckTimer
        interval: 100
        running: true
        repeat: true

        onTriggered: {
            if (item.defaultAudioSink && item.defaultAudioSink.audio) {
                sinkCheckTimer.stop();
                connections.target = item.defaultAudioSink.audio;
            }
        }
    }

    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: item.shouldShowOsd = false
    }

    LazyLoader {
        active: item.shouldShowOsd

        PanelWindow {
            anchors.bottom: true
            margins.bottom: Screen.height / 15
            exclusiveZone: 0

            implicitWidth: 400
            implicitHeight: 50
            color: "transparent"

            mask: Region {}

            Rectangle {
                anchors.fill: parent
                radius: height / 2
                color: Theme.get.transparentBackgroundColor

                RowLayout {
                    anchors {
                        fill: parent
                        leftMargin: 10
                        rightMargin: 15
                    }

                    Icon {
                        color: Theme.get.pineColor
                        size: 30
                        iconName: {
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
                    }

                    Rectangle {
                        Layout.fillWidth: true

                        implicitHeight: 10
                        radius: 20
                        color: Theme.get.subtleColor

                        Rectangle {
                            anchors {
                                left: parent.left
                                top: parent.top
                                bottom: parent.bottom
                            }

                            implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
                            radius: parent.radius
                        }
                    }

                    Text {
                        text: item.volume + "%"
                        font.pixelSize: 14
                        font.weight: Font.Bold
                        color: Theme.get.textColor
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }
        }
    }

    width: iconSize
    height: pillHeight

    Rectangle {
        id: iconCircle
        width: item.iconSize
        height: item.iconSize
        color: "transparent"

        Icon {
            color: Theme.get.goldColor
            size: 24
            iconName: {
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
