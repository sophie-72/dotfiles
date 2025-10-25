pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string utilizationPercentage
    property real lastCpuTotal
    property real lastCpuIdle

    Process {
        id: process
        command: ["sh", "-c", "head -n 1 /proc/stat"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const data = this.text.replace("\n", "").split(" ").slice(2).map(n => parseInt(n, 10));
                const total = data.reduce((a, b) => a + b, 0);
                const idle = data[3] + data[4];

                const totalDiff = total - root.lastCpuTotal;
                const idleDiff = idle - root.lastCpuIdle;

                root.utilizationPercentage = ((1 - idleDiff / totalDiff) * 100).toFixed(2);
                root.lastCpuTotal = total;
                root.lastCpuIdle = idle;
            }
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
