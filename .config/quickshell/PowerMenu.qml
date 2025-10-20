pragma Singleton

import QtQuick
import QtQuick.Layouts
import Quickshell

Singleton {
    id: root
    
    property bool visible
    
    PanelWindow {
        focusable: true
        implicitWidth: 400
        implicitHeight: 300
        visible: root.visible
        color: "transparent"

        Rectangle {
            focus: true
            anchors.fill: parent
            color: Theme.get.transparentBackgroundColor
            radius: 10

            ColumnLayout {
                anchors.fill: parent

                Text {
                    text: "test :D"
                }
            }

            Keys.onEscapePressed: () => {
                root.visible = false;
            }
        }
    }
}
