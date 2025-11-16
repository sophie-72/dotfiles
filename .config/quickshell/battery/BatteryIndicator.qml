import QtQuick
import QtQuick.Layouts
import qs

Rectangle {
    property real percentage
    
    width: parent.width
    height: parent.height
    color: "transparent"

    Icon {
        color: Theme.get.roseColor
        size: 24
        iconName: {
            if (parent.percentage == 1) {
                return "battery-full";
            } else if (parent.percentage >= 0.75) {
                return "battery-three-quarters";
            } else if (parent.percentage >= 0.50) {
                return "battery-half";
            } else if (parent.percentage >= 0.25) {
                return "battery-quarter";
            } else {
                return "battery-empty";
            }
        }
        Layout.alignment: Qt.AlignCenter
    }
}
