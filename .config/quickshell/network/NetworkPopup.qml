import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs

PopupWindow {
    id: networkPopup

    anchor.item: networkWidget
    anchor.rect.x: networkWidget.x + 40
    implicitWidth: 250
    implicitHeight: 75
    visible: false
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: Theme.get.transparentBackgroundColor
        radius: 10

        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: 10

            Text {
                id: currentConnectedNetwork

                text: "Connected to "
                color: Theme.get.textColor
                font.weight: Font.Bold
            }
        }

        ConnectedNetwork {}
    }
}
