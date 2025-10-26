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

        Icon {
            color: Theme.get.goldColor
            size: 24
            iconName: {
                if (batteryWidget.percentage == 1) {
                    return "battery-full";
                } else if (batteryWidget.percentage >= 0.75) {
                    return "battery-three-quarters";
                } else if (batteryWidget.percentage >= 0.50) {
                    return "battery-half";
                } else if (batteryWidget.percentage >= 0.25) {
                    return "battery-quarter";
                } else {
                    return "battery-empty";
                }
            }
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
