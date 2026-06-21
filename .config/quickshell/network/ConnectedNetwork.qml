pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property string currentConnectedNetwork

    Process {
        id: getNetworks

        running: true
        command: ["iwctl", "station", "wlan0", "show"]
        stdout: StdioCollector {
            onStreamFinished: {
                const lines = this.text.split("\n");
                let foundSSID = "Disconnected";

                for (let line of lines) {
                    if (line.includes("Connected network")) {
                        foundSSID = line.replace("Connected network", "").trim();
                        break;
                    }
                }
                root.currentConnectedNetwork = foundSSID;
            }
        }
    }
}
