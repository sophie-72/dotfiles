import Qt5Compat.GraphicalEffects
import QtQuick
import Quickshell
import Quickshell.Widgets

Item {
    id: icon

    property string color
    property int size
    property string iconName
    property string iconsFolder: Qt.resolvedUrl(Quickshell.shellPath("assets/icons/"))

    width: size
    height: size

    IconImage {
        id: iconImage
        anchors.fill: parent
        implicitSize: parent.size
        source: parent.iconsFolder + parent.iconName + ".svg"
    }

    Loader {
        anchors.fill: iconImage
        sourceComponent: ColorOverlay {
            source: iconImage
            color: icon.color
        }
    }
}
