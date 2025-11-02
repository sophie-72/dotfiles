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
                text: "Connected"
                color: Theme.get.textColor
                font.weight: Font.Bold
            }

            Repeater {
                model: ScriptModel {
                    values: [...Bluetooth.devices.values].filter(device => device.connected).sort((a, b) => (b.connected - a.connected))
                }

                Text {
                    id: connectedDevice

                    required property BluetoothDevice modelData

                    text: connectedDevice.modelData.name
                    color: Theme.get.textColor
                    font.weight: Font.Bold
                }
            }
            Text {
                text: "Paired"
                color: Theme.get.textColor
                font.weight: Font.Bold
            }

            Repeater {
                model: ScriptModel {
                    values: [...Bluetooth.devices.values].filter(device => device.paired).sort((a, b) => (b.paired - a.paired))
                }

                Text {
                    id: pairedDevice

                    required property BluetoothDevice modelData

                    text: pairedDevice.modelData.name
                    color: Theme.get.textColor
                    font.weight: Font.Bold
                }
            }
        }
    }
}
