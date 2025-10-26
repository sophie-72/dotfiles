import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import qs

Item {
    id: osd

    property string iconName
    property int volume
    property var audioSink

    property bool shouldShowOsd: false
    property bool suppressVolumeChange: true

    PwObjectTracker {
        objects: [osd.audioSink]
    }

    Connections {
        id: connections

        function onVolumeChanged() {
            if (osd.suppressVolumeChange) {
                osd.suppressVolumeChange = false;
            } else {
                osd.shouldShowOsd = true;
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
            if (osd.audioSink && osd.audioSink.audio) {
                sinkCheckTimer.stop();
                connections.target = osd.audioSink.audio;
            }
        }
    }

    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: osd.shouldShowOsd = false
    }

    LazyLoader {
        active: osd.shouldShowOsd

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
                        iconName: osd.iconName
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

                            implicitWidth: parent.width * (osd.audioSink?.audio.volume ?? 0)
                            radius: parent.radius
                        }
                    }

                    Text {
                        text: osd.volume + "%"
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
}
