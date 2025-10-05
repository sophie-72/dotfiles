import QtQuick
import Quickshell.Services.UPower

Text {
    text: (UPower.displayDevice.percentage * 100) + "%"
    color: Theme.get.textColor
}
