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
    color: Theme.accentColor
    radius: buttonRadius
    Layout.alignment: Qt.AlignHCenter

    Icon {
        color: Theme.backgroundColor
        size: parent.iconSize
        iconName: "moon"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    MouseArea {
        anchors.fill: parent

        Process {
            id: suspendProcess

            running: false
            command: ["systemctl", "suspend"]
        }

        onClicked: suspendProcess.running = true
    }
}

