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
        radius: 6
        color: Theme.get.pineColor
        smooth: true

        ColumnLayout {
            spacing: 1
            anchors.fill: parent
            
            BatteryIcon {
                color: Theme.get.backgroundColor
                size: 18
                percentage: widget.percentage
                Layout.alignment: Qt.AlignCenter
            }

            Text {
                text: (widget.percentage * 100)
                font.pixelSize: 14
                font.weight: Font.Bold
                color: Theme.get.backgroundColor
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignCenter
            }
        }
    }
}
