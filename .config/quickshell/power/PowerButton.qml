import QtQuick
import QtQuick.Layouts
import qs

Rectangle {
    property int buttonSize
    property real buttonRadius
    property int iconSize

    implicitWidth: buttonSize
    implicitHeight: buttonSize
    color: Theme.get.loveColor
    radius: buttonRadius
    Layout.alignment: Qt.AlignHCenter

    PowerIcon {
        color: Theme.get.backgroundColor
        size: parent.iconSize
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
