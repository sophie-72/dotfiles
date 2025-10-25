import Qt5Compat.GraphicalEffects
import QtQuick
import Quickshell
import Quickshell.Widgets

Item {
    id: powerIcon

    property string color
    property int size
    property string iconsFolder: Qt.resolvedUrl(Quickshell.shellPath("assets/icons/"))

    width: size
    height: size

    IconImage {
        id: powerIconImage
        anchors.fill: parent
        implicitSize: parent.size
        source: parent.iconsFolder + "power-off.svg"
    }

    Loader {
        anchors.fill: powerIconImage
        sourceComponent: ColorOverlay {
            source: powerIconImage
            color: powerIcon.color
        }
    }
}
