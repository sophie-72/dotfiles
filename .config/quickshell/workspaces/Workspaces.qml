import Quickshell.Hyprland
import QtQuick
import qs

Repeater {
    model: Hyprland.workspaces

    Rectangle {
        width: 32
        height: 24
        color: "transparent"

        MouseArea {
            anchors.fill: parent
            onClicked: modelData.activate()
        }

        Icon {
            color: (modelData.focused || modelData.active) ? Theme.get.pineColor : Theme.get.mutedColor
            size: 18
            iconName:  modelData.focused ? "circle-dot" : "circle"
            anchors.centerIn: parent
        }
    }
}
