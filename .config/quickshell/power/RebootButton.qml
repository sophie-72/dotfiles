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
    color: Theme.get.roseColor
    radius: buttonRadius
    Layout.alignment: Qt.AlignHCenter

    RebootIcon {
        color: Theme.get.backgroundColor
        size: parent.iconSize
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    MouseArea {
        anchors.fill: parent

        Process {
            id: rebootProcess

            running: false
            command: ["systemctl", "reboot"]
        }

        onClicked: rebootProcess.running = true
    }
}

