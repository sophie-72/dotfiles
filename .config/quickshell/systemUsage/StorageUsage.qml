pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property list<var> devices

    Process {
        id: process
        command: ["sh", "-c", "df -h | grep '^/dev/' | awk '{print $1, $2, $3, $4, $6}'"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const devices = [];
                for (const line of this.text.split("\n")) {
                    if (line === "") {
                        continue;
                    }
                    const values = line.split(" ");
                    const device = values[0];

                    devices.push({
                        device: values[0],
                        size: values[1],
                        used: values[2],
                        available: values[3],
                        mountedOn: values[4]
                    });
                }
                root.devices = devices;
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
