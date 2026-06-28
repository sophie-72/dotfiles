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
    implicitHeight: contentLayout.implicitHeight + 20
    visible: false
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: Theme.transparentBackgroundColor
        radius: 10

        ColumnLayout {
            id: contentLayout
            anchors.fill: parent
            anchors.leftMargin: 10

            Text {
                text: "Connected to " + ConnectedNetwork.currentConnectedNetwork
                color: Theme.textColor
                font.weight: Font.Bold
            }

            Text {
                text: NetworkInterfaces.interfaces
                color: Theme.textColor
            }
        }
    }
}
