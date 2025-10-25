import Qt5Compat.GraphicalEffects
import QtQuick
import Quickshell
import Quickshell.Widgets

Item {
    id: keyboardIcon

    property string color
    property int size
    property string iconsFolder: Qt.resolvedUrl(Quickshell.shellPath("assets/icons/"))

    width: size
    height: size

    IconImage {
        id: keyboardIconImage
        anchors.fill: parent
        implicitSize: parent.size
        source: parent.iconsFolder + "keyboard.svg"
    }

    Loader {
        anchors.fill: keyboardIconImage
        sourceComponent: ColorOverlay {
            source: keyboardIconImage
            color: keyboardIcon.color
        }
    }
}
