import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import qs

Rectangle {
    property int buttonSize
    property real buttonRadius
    property int iconSize

    implicitWidth: buttonSize
    implicitHeight: buttonSize
    color: Theme.get.goldColor
    radius: buttonRadius
    Layout.alignment: Qt.AlignHCenter


    Icon {
        color: Theme.get.backgroundColor
        size: parent.iconSize
        iconName: "lock"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    MouseArea {
        anchors.fill: parent

        Process {
            id: lockProcess

            running: false
            command: ["hyprlock"]
        }

        onClicked: lockProcess.running = true
    }
}

