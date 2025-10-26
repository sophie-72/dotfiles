import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower
import qs

Item {
    id: batteryWidget

    readonly property UPowerDevice device: UPower.displayDevice
    readonly property real percentage: device.percentage

    property int backgroundSize: 26

    width: backgroundSize
    height: backgroundSize

    Rectangle {
        width: batteryWidget.backgroundSize
        height: parent.height
        color: "transparent"

        BatteryIcon {
            color: Theme.get.goldColor
            size: 24
            percentage: batteryWidget.percentage
            Layout.alignment: Qt.AlignCenter
        }
    }

    BatteryPopup {
        id: batteryPopup
        device: batteryWidget.device
    }

    MouseArea {
        anchors.fill: batteryWidget
        hoverEnabled: true
        onEntered: () => {
            batteryPopup.visible = true;
        }
        onExited: () => {
            batteryPopup.visible = false;
        }
    }
}
