import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower

PopupWindow {
    id: batteryPopup

    anchor.item: batteryWidget
    anchor.rect.x: batteryWidget.x + 40
    implicitWidth: 250
    implicitHeight: 75
    visible: false
    color: "transparent"

    property UPowerDevice device
    property bool isCharging: device.state == UPowerDeviceState.Charging
    property bool isDischarging: device.state == UPowerDeviceState.Discharging

    Rectangle {
        anchors.fill: parent
        color: Theme.get.transparentBackgroundColor
        radius: 10

        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: 10

            Text {
                text: (batteryPopup.device.percentage * 100) + "% (" + UPowerDeviceState.toString(batteryPopup.device.state) + ")"
                color: Theme.get.textColor
                font.weight: Font.Bold
            }

            Text {
                text: {
                    let time = 0;
                    let output = "";

                    if (batteryPopup.isCharging) {
                        time = batteryPopup.device.timeToFull;
                        output += "Fully charged in ";
                    } else if (batteryPopup.isDischarging) {
                        time = batteryPopup.device.timeToEmpty;
                        output += "Fully discharged in ";
                    }

                    const hours = Math.floor(time / 3600);
                    const minutes = Math.floor((time % 3600) / 60);

                    if (hours != 0) {
                        output += hours + " h ";
                    }

                    if (minutes != 0) {
                        output += minutes + " m ";
                    }

                    return output;
                }
                color: Theme.get.textColor
                font.weight: Font.Bold
            }
        }
    }
}
