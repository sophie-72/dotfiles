import Qt5Compat.GraphicalEffects
import QtQuick
import Quickshell
import Quickshell.Widgets

Item {
    id: workspaceIcon

    property int size
    property bool isFocused
    property bool isActive
    property string iconsFolder: Qt.resolvedUrl(Quickshell.shellPath("assets/icons/"))

    width: size
    height: size

    IconImage {
        id: workspaceIconImage
        anchors.fill: parent
        implicitSize: parent.size
        source: parent.isFocused ? parent.iconsFolder + "circle-dot.svg" : parent.iconsFolder + "circle.svg"
    }

    Loader {
        anchors.fill: workspaceIconImage
        sourceComponent: ColorOverlay {
            source: workspaceIconImage
            color: (workspaceIcon.isFocused || workspaceIcon.isActive) ? Theme.get.pineColor : Theme.get.overlayColor
        }
    }
}
