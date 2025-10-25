import QtQuick
import qs

Item {
    id: systemUsageWidget

    property int backgroundSize: 26

    width: backgroundSize
    height: backgroundSize

    Rectangle {
        width: parent.width
        height: parent.height
        color: "transparent"

        SystemUsageIcon {
            color: Theme.get.goldColor
            size: 24
        }
    }

    SystemUsagePopup {
        id: systemUsagePopup
    }

    MouseArea {
        anchors.fill: systemUsageWidget
        hoverEnabled: true
        onEntered: () => {
            systemUsagePopup.visible = true;
        }
        onExited: () => {
            systemUsagePopup.visible = false;
        }
    }
}
