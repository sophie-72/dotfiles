import Quickshell
import Quickshell.Hyprland
import QtQuick

Repeater {
    model: Hyprland.workspaces

    Rectangle {
        width: 32
        height: 24
        radius: 15
        color: modelData.active ? Theme.get.goldColor : Theme.get.pineColor
        border.color: Theme.get.foamColor
        border.width: 2

        MouseArea {
            anchors.fill: parent
            onClicked: Hyprland.dispatch("workspaces " + modelData.id)
        }

        Text {
            text: modelData.id
            anchors.centerIn: parent
            color: modelData.active ? Theme.get.loveColor : Theme.get.irisColor
            font.pixelSize: 12
            font.family: "Inter, sans-serif"
        }        
    }
}

