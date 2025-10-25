import Qt5Compat.GraphicalEffects
import QtQuick
import Quickshell
import Quickshell.Widgets

Item {
    id: systemUsageIcon

    property string color
    property int size
    property string iconsFolder: Qt.resolvedUrl(Quickshell.shellPath("assets/icons/"))

    width: size
    height: size

    IconImage {
        id: systemUsageIconImage
        anchors.fill: parent
        implicitSize: parent.size
        source: parent.iconsFolder + "gauge-high.svg"
    }

    Loader {
        anchors.fill: systemUsageIconImage
        sourceComponent: ColorOverlay {
            source: systemUsageIconImage
            color: systemUsageIcon.color
        }
    }
}
