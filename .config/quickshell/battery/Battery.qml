import QtQuick
import Quickshell.Services.UPower
import qs

Item {
    id: batteryWidget

    readonly property UPowerDevice device: UPower.displayDevice
    readonly property real percentage: device.percentage

    property int backgroundSize: 26

    visible: device.isLaptopBattery

    width: backgroundSize
    height: backgroundSize

    BatteryIndicator {
        percentage: parent.percentage
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
