import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Bluetooth
import qs

PopupWindow {
    id: bluetoothPopup

    anchor.item: bluetoothWidget
    anchor.rect.x: bluetoothWidget.x + 40
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
                text: "Connected Devices"
                color: Theme.textColor
                font.weight: Font.Bold
            }

            Repeater {
                model: ScriptModel {
                    values: [...Bluetooth.devices.values].filter(device => device.connected).sort((a, b) => (b.connected - a.connected))
                }

                Text {
                    id: connectedDevice

                    required property BluetoothDevice modelData

                    text: " ".repeat(4) + connectedDevice.modelData.name
                    color: Theme.textColor
                }
            }

            Text {
                text: "No devices connected"
                color: Theme.textColor
                visible: contentLayout.children.length <= 3
            }
        }
    }
}
