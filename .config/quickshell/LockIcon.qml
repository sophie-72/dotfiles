import Qt5Compat.GraphicalEffects
import QtQuick
import Quickshell
import Quickshell.Widgets

Item {
    id: lockIcon

    property string color
    property int size
    property string iconsFolder: Qt.resolvedUrl(Quickshell.shellPath("assets/icons/"))

    width: size
    height: size

    IconImage {
        id: lockIconImage
        anchors.fill: parent
        implicitSize: parent.size
        source: parent.iconsFolder + "lock.svg"
    }

    Loader {
        anchors.fill: lockIconImage
        sourceComponent: ColorOverlay {
            source: lockIconImage
            color: lockIcon.color
        }
    }
}

