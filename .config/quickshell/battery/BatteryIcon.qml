import Qt5Compat.GraphicalEffects
import QtQuick
import Quickshell
import Quickshell.Widgets

Item {
    id: batteryIcon
    
    property string color
    property int size
    property real percentage
    property string iconsFolder: Qt.resolvedUrl(Quickshell.shellPath("assets/icons/"))

    width: size
    height: size

    IconImage {
        id: batteryIconImage
        anchors.fill: parent
        implicitSize: parent.size
        source: {
            if (parent.percentage == 1) {
                return parent.iconsFolder + "battery-full.svg";
            } else if (parent.percentage >= 0.75) {
                return parent.iconsFolder + "battery-three-quarters.svg";
            } else if (parent.percentage >= 0.50) {
                return parent.iconsFolder + "battery-half.svg";
            } else if (parent.percentage >= 0.25) {
                return parent.iconsFolder + "battery-quarter.svg";
            } else {
                return parent.iconsFolder + "battery-empty.svg";
            }
        }
    }

    Loader {
        anchors.fill: batteryIconImage
        sourceComponent: ColorOverlay {
            source: batteryIconImage
            color: batteryIcon.color
        }
    }
}
