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
    color: Theme.errorColor
    radius: buttonRadius
    Layout.alignment: Qt.AlignHCenter

    Icon {
        color: Theme.backgroundColor
        size: parent.iconSize
        iconName: "power-off"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    MouseArea {
        anchors.fill: parent

        Process {
            id: powerOffProcess

            running: false
            command: ["systemctl", "poweroff"]
        }

        onClicked: powerOffProcess.running = true
    }
}
