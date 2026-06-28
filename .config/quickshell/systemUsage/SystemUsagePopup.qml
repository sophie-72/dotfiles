import QtQuick
import QtQuick.Layouts
import Quickshell
import qs

PopupWindow {
    id: systemUsagePopup

    anchor.item: systemUsageWidget
    anchor.rect.x: systemUsageWidget.x + 40
    implicitWidth: 280
    implicitHeight: contentLayout.implicitHeight + 24
    visible: false
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: Theme.transparentBackgroundColor
        radius: 10

        ColumnLayout {
            id: contentLayout
            anchors.fill: parent
            anchors.margins: 12
            spacing: 10

            ColumnLayout {
                spacing: 2

                Text {
                    text: "CPU Utilization"
                    font.weight: Font.DemiBold
                    font.pointSize: 9
                    color: Theme.textColor
                    opacity: 0.7
                }

                Text {
                    text: CpuUsage.utilizationPercentage + "%"
                    font.weight: Font.Bold
                    font.pointSize: 12
                    color: Theme.textColor
                }
            }

            ColumnLayout {
                spacing: 2

                Text {
                    text: "Memory Usage"
                    font.weight: Font.DemiBold
                    font.pointSize: 9
                    color: Theme.textColor
                    opacity: 0.7
                }

                Text {
                    text: MemoryUsage.usedMemory + " / " + MemoryUsage.totalMemory
                    font.weight: Font.Bold
                    color: Theme.textColor
                }
            }

            ColumnLayout {
                spacing: 4
                Layout.fillWidth: true

                Text {
                    text: "Storage"
                    font.weight: Font.DemiBold
                    font.pointSize: 9
                    color: Theme.textColor
                    opacity: 0.7
                }

                Repeater {
                    model: StorageUsage.devices || []
                    
                    delegate: ColumnLayout {
                        spacing: 2
                        Layout.fillWidth: true
                        
                        Text {
                            text: modelData.device + " (" + modelData.mountedOn + ")"
                            font.weight: Font.Bold
                            color: Theme.textColor
                        }
                        
                        Text {
                            text: "Used: " + modelData.used + " | Avail: " + modelData.available + " (Total: " + modelData.size + ")"
                            font.pointSize: 9
                            color: Theme.textColor
                            opacity: 0.8
                            Layout.leftMargin: 8
                        }
                    }
                }
            }
        }
    }
}
