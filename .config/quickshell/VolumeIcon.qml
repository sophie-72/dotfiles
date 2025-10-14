import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Widgets

Item {
    id: volumeIcon
    width: 30
    height: 30

    property int volume
    property string iconsFolder: Qt.resolvedUrl(Quickshell.shellPath("assets/icons/"))

    IconImage {
        id: volumeIconImage
        implicitSize: 30
        source: {
            if (parent.volume > 50) {
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
            color: Theme.get.pineColor
        }
    }
}
