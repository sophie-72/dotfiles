import QtQuick

Text {
    text: (Battery.percentage * 100) + "%"
    color: Theme.get.textColor 
}
