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

        Icon {
            color: Theme.get.roseColor
            size: 24
            iconName: "gauge-high"
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
