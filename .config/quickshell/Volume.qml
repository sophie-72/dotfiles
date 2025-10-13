import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io
import Quickshell.Widgets

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

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    Connections {
        target: Pipewire.defaultAudioSink?.audio

        function onVolumeChanged() {
            item.shouldShowOsd = true;
            hideTimer.restart();
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
            margins.bottom: Screen.height / 5
            exclusiveZone: 0

            implicitWidth: 400
            implicitHeight: 50
            color: "transparent"

            mask: Region {}

            Rectangle {
                anchors.fill: parent
                radius: height / 2
                color: "#80000000"

                RowLayout {
                    anchors {
                        fill: parent
                        leftMargin: 10
                        rightMargin: 15
                    }

                    IconImage {
                        implicitSize: 30
                        source: Quickshell.iconPath("audio-volume-high-symbolic")
                    }

                    Rectangle {
                        Layout.fillWidth: true

                        implicitHeight: 10
                        radius: 20
                        color: "#50ffffff"

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
                }
            }
        }
    }

    width: iconSize + maxPillWidth - pillOverlap
    height: pillHeight * 3

    Column {
        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            id: iconCircle
            width: item.iconSize
            height: item.iconSize
            radius: width / 2
            color: Theme.get.goldColor
            smooth: true

            Behavior on color {
                ColorAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }

            Text {
                id: icon
                anchors.centerIn: iconCircle
                font.family: "Material Symbols Outlined"
                font.pixelSize: 14
                color: Theme.get.backgroundColor
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

                text: {
                    if (item.volumeMuted || item.volume === 0)
                        return "";
                    else if (item.volume > 0 && item.volume < 30)
                        return "";
                    else
                        return "";
                }
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

        Rectangle {
            id: percentageContainer
            topLeftRadius: item.pillHeight / 2
            bottomLeftRadius: item.pillHeight / 2
            color: Theme.get.pineColor
            height: item.pillHeight
            width: 50
            opacity: 1

            Text {
                id: percentageText
                anchors.centerIn: parent
                text: item.volume + "%"
                font.pixelSize: 14
                font.weight: Font.Bold
                color: Theme.get.textColor
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                clip: true
            }
        }
    }
}
