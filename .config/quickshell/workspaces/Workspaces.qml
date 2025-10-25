import Quickshell.Hyprland
import QtQuick

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

        WorkspaceIcon {
            size: 18
            isFocused: modelData.focused
            isActive: modelData.active
            anchors.centerIn: parent
        }
    }
}
