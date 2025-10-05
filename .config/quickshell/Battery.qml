pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.UPower

Singleton {
    readonly property UPowerDevice device: UPower.displayDevice
    readonly property real percentage: UPower.displayDevice.percentage
    readonly property string icon: percentage == 1 ? "" : percentage >= 0.75 ? "" : percentage >= 0.50 ? "" : percentage >= 0.25 ? "" : ""
}
