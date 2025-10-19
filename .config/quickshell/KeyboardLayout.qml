pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property string layout

    Process {
        id: process
        command: ["sh", "-c", "hyprctl devices -j | jq -r '.keyboards[] | .active_keymap' | tail -n 1 | awk -F'\\(' '{ if (NF>1) print substr($0, 1, 2)}' | tr 'A-Z' 'a-z'"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.layout = this.text
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            process.running = true;
        }
    }
}
