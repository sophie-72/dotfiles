import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower

Item {
    id: widget

    readonly property UPowerDevice device: UPower.displayDevice
    readonly property real percentage: device.percentage

    property int backgroundSize: 26

    width: backgroundSize
    height: backgroundSize * 1.5

    Rectangle {
        width: widget.backgroundSize
        height: parent.height
        color: "transparent"

        ColumnLayout {
            spacing: 1
            anchors.fill: parent
            
            BatteryIcon {
                color: Theme.get.pineColor
                size: 24
                percentage: widget.percentage
                Layout.alignment: Qt.AlignCenter
            }

            Text {
                text: (widget.percentage * 100) + "%"
                font.pixelSize: 10
                font.weight: Font.Bold
                color: Theme.get.pineColor
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignCenter
            }
        }
    }
}
