import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs

PopupWindow {
    id: networkPopup

    anchor.item: networkWidget
    anchor.rect.x: networkWidget.x + 40
    implicitWidth: 260
    implicitHeight: contentLayout.implicitHeight + 24
    visible: false
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: Theme.transparentBackgroundColor
        radius: 10

        ColumnLayout {
            id: contentLayout
            anchors.fill: parent
            anchors.margins: 12
            spacing: 10

            ColumnLayout {
                spacing: 2

                Text {
                    text: "Network Status"
                    font.weight: Font.DemiBold
                    font.pointSize: 9
                    color: Theme.textColor
                    opacity: 0.7
                }

                Text {
                    text: ConnectedNetwork.currentConnectedNetwork ? ConnectedNetwork.currentConnectedNetwork : "Disconnected"
                    font.weight: Font.Bold
                    font.pointSize: 11
                    color: Theme.textColor
                }
            }

            ColumnLayout {
                spacing: 4
                Layout.fillWidth: true

                Text {
                    text: "Active Interfaces"
                    font.weight: Font.DemiBold
                    font.pointSize: 9
                    color: Theme.textColor
                    opacity: 0.7
                }

                Repeater {
                    model: NetworkInterfaces.interfaceList || []

                    delegate: ColumnLayout {
                        spacing: 1
                        Layout.fillWidth: true

                        Text {
                            text: modelData.name
                            font.weight: Font.Bold
                            color: Theme.textColor
                        }

                        Text {
                            text: modelData.ip
                            font.pointSize: 9
                            color: Theme.textColor
                            opacity: 0.8
                            Layout.leftMargin: 8
                        }
                    }
                }
            }
        }
    }
}
