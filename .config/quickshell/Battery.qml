import QtQuick

Item {
    id: widget
    
    property int backgroundSize: 26
    
    width: backgroundSize
    height: backgroundSize
    
    Rectangle {
        width: widget.backgroundSize
        height: widget.backgroundSize
        radius: 6
        color: Theme.get.pineColor
        smooth: true

        BatteryIcon {
            color: Theme.get.backgroundColor
            size: 18
            anchors.centerIn: parent
        }
    }
}
