import Qt5Compat.GraphicalEffects
import QtQuick
import Quickshell
import Quickshell.Widgets

Item {
    id: updatesIcon

    property string color
    property int size
    property string iconsFolder: Qt.resolvedUrl(Quickshell.shellPath("assets/icons/"))

    width: size
    height: size

    IconImage {
        id: updatesIconImage
        anchors.fill: parent
        implicitSize: parent.size
        source: parent.iconsFolder + "circle-up.svg"
    }

    Loader {
        anchors.fill: updatesIconImage
        sourceComponent: ColorOverlay {
            source: updatesIconImage
            color: updatesIcon.color
        }
    }
}
