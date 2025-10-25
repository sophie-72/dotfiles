import Qt5Compat.GraphicalEffects
import QtQuick
import Quickshell
import Quickshell.Widgets

Item {
    id: rebootIcon

    property string color
    property int size
    property string iconsFolder: Qt.resolvedUrl(Quickshell.shellPath("assets/icons/"))

    width: size
    height: size

    IconImage {
        id: rebootIconImage
        anchors.fill: parent
        implicitSize: parent.size
        source: parent.iconsFolder + "arrows-rotate.svg"
    }

    Loader {
        anchors.fill: rebootIconImage
        sourceComponent: ColorOverlay {
            source: rebootIconImage
            color: rebootIcon.color
        }
    }
}

