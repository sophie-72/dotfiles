pragma Singleton

import QtQuick
import Quickshell

// Rose Pine Moon
Singleton {
    property Item get: rosePineMoon

    Item {
        id: rosePineMoon

        property string backgroundColor: "#232136"
        property string textColor: "#e0def4"
        property string loveColor: "#eb6f92"
        property string goldColor: "#f6c177"
        property string roseColor: "#ea9a97"
        property string pineColor: "#3e8fb0"
        property string foamColor: "#9ccfd8"
        property string irisColor: "#c4a7e7"
    }
}
