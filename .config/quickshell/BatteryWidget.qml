import QtQuick

Text {
    text: Battery.icon //+ "\n" + (Battery.percentage * 100) + "%"
    color: Theme.get.textColor
    font.pointSize: 20
}
