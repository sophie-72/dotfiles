import Quickshell

PopupWindow {
    anchor.window: bar
    anchor.rect.x: bar.width + 10
    anchor.rect.y: bar.height - (batteryWidget.y * 4)
    visible: false
}
