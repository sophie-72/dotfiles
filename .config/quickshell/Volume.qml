import Quickshell.Services.Pipewire
import Quickshell.Io
import QtQuick

Item {
    id: item

    property var defaultAudioSink: Pipewire.defaultAudioSink
    property int volume: defaultAudioSink && defaultAudioSink.audio ? Math.round(defaultAudioSink.audio.volume) * 100 : 0
    property bool volumeMuted: defaultAudioSink && defaultAudioSink.audio ? defaultAudioSink.audio.muted : false

    readonly property int iconSize: 22
    readonly property int pillHeight: 22
    readonly property int pillPaddingHorizontal: 14
    readonly property int pillOverlap: iconSize / 2

    property int maxPillWidth: 0
    property bool showPercentage: false

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    width: Math.max(iconSize, showPercentage ? iconSize + maxPillWidth - pillOverlap : iconSize)
    height: pillHeight

    onVolumeChanged: {
        if (!showPercentage) {
            showPercentage = true;
            showHideAnimation.start();
        } else {
            showHideAnimation.restart();
        }
    }

    Component.onCompleted: {
        maxPillWidth = percentageText.implicitWidth + pillPaddingHorizontal * 2 + pillOverlap;
        percentageContainer.width = 0;
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"

        Rectangle {
            id: percentageContainer
            topLeftRadius: item.pillHeight / 2
            bottomLeftRadius: item.pillHeight / 2
            color: Theme.get.pineColor
            height: item.pillHeight
            width: 0
            anchors.verticalCenter: parent.verticalCenter

            x: (iconCircle.x + iconCircle.width / 2) - width

            opacity: 0
            visible: width > 0

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

        Rectangle {
            id: iconCircle
            width: item.iconSize
            height: item.iconSize
            radius: width / 2
            color: item.showPercentage ? Theme.get.goldColor : "transparent"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            smooth: true

            Behavior on color {
                ColorAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        }

        Text {
            id: icon
            anchors.centerIn: iconCircle
            font.family: "Material Symbols Outlined"
            font.pixelSize: 14
            color: item.showPercentage ? Theme.get.backgroundColor : Theme.get.textColor
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

    SequentialAnimation {
        id: showHideAnimation
        running: false

        ParallelAnimation {
            NumberAnimation {
                target: percentageContainer
                property: "width"
                from: 0
                to: item.maxPillWidth
                duration: 250
                easing.type: Easing.OutCubic
            }

            NumberAnimation {
                target: percentageContainer
                property: "opacity"
                from: 0
                to: 1
                duration: 250
                easing.type: Easing.InCubic
            }
        }

        onStopped: {
            item.showPercentage = false;
        }
    }
}
