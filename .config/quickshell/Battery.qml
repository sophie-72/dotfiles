pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.UPower

Singleton {
    readonly property UPowerDevice device: UPower.displayDevice
    readonly property real percentage: UPower.displayDevice.percentage
}
