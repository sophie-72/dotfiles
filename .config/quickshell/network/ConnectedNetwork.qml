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
        command: ["nmcli", "-g", "ACTIVE,SSID", "d", "w"]
        stdout: StdioCollector {
            onStreamFinished: {
                const networks = this.text.trim().split("\n").map(n => {
                    const network = n.split(":");
                    return {
                        active: network[0] === "yes",
                        ssid: network[1]
                    };
                }).filter(n => n.active);
                root.currentConnectedNetwork = networks[0].ssid;
            }
        }
    }
}
