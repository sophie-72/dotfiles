import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Bluetooth
import qs

PopupWindow {
    id: bluetoothPopup

    anchor.item: bluetoothWidget
    anchor.rect.x: bluetoothWidget.x + 40
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
            spacing: 8

            ColumnLayout {
                spacing: 2
                Text {
                    text: "Bluetooth"
                    font.weight: Font.DemiBold
                    font.pointSize: 9
                    color: Theme.textColor
                    opacity: 0.7
                }
                Text {
                    text: "Connected Devices"
                    font.weight: Font.Bold
                    font.pointSize: 11
                    color: Theme.textColor
                }
            }

            Repeater {
                model: Bluetooth.devices

                delegate: Text {
                    visible: modelData.connected
                    height: visible ? implicitHeight : 0
                    width: visible ? implicitWidth : 0
                    text: "•  " + modelData.name
                    font.weight: Font.DemiBold
                    color: Theme.textColor
                    Layout.leftMargin: visible ? 4 : 0
                }
            }

            Text {
                text: "No devices connected"
                font.italic: true
                font.pointSize: 10
                color: Theme.textColor
                opacity: 0.5
                visible: {
                    if (!Bluetooth.devices || Bluetooth.devices.values.length === 0) return true;
                    return !Bluetooth.devices.values.some(device => device.connected);
                }
            }
        }
    }
}
