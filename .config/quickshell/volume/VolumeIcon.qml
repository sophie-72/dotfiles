import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Widgets

Item {
    id: volumeIcon

    property string color
    property int size
    property int volume
    property bool isVolumeMuted
    property string iconsFolder: Qt.resolvedUrl(Quickshell.shellPath("assets/icons/"))

    width: size
    height: size

    IconImage {
        id: volumeIconImage
        anchors.fill: parent
        implicitSize: parent.size
        source: {
            if (parent.isVolumeMuted) {
                return parent.iconsFolder + "volume-xmark.svg";
            } else if (parent.volume > 50) {
                return parent.iconsFolder + "volume-high.svg";
            } else if (parent.volume > 0) {
                return parent.iconsFolder + "volume-low.svg";
            } else {
                return parent.iconsFolder + "volume-off.svg";
            }
        }
    }

    Loader {
        anchors.fill: volumeIconImage
        sourceComponent: ColorOverlay {
            source: volumeIconImage
            color: volumeIcon.color
        }
    }
}
