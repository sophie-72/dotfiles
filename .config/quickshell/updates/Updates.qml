import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import qs

Item {
    property int backgroundSize: 26

    width: backgroundSize
    height: backgroundSize * 2

    Rectangle {
        id: updates
        width: parent.width
        height: parent.height
        color: "transparent"

        ColumnLayout {
            UpdatesIcon {
                color: Theme.get.pineColor
                size: 24
                Layout.alignment: Qt.AlignCenter
            }

            Text {
                text: UpdatesCount.count
                font.weight: Font.Bold
                color: Theme.get.textColor
                Layout.alignment: Qt.AlignCenter
            }
        }

        Process {
            id: update
            running: false
            command: ["sh", "-c", "kitty --hold sh -c 'paru -Syu'"]
        }

        MouseArea {
            anchors.fill: updates
            acceptedButtons: Qt.LeftButton

            onClicked: update.startDetached()
        }
    }
}
