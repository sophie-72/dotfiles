pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: theme

    property string backgroundColor: "#232136"
    property string transparentBackgroundColor: "#E6232136"
    property string overlayColor: "#393552"
    property string mutedColor: "#6e6a86"
    property string subtleColor: "#908caa"
    property string textColor: "#e0def4"
    property string accentColor: "#3e8fb0"
    property string errorColor: "#eb6f92"
    property string outlineColor: "#6e6a86"

    FileView {
        id: themeReader
        path: Quickshell.configDir + "/colors.json"
        
        onTextChanged: (text) => {
            try {
                let parsed = JSON.parse(text);
                let colors = parsed.colors;

                theme.backgroundColor = colors.background;
                theme.transparentBackgroundColor = "#E6" + colors.background.replace("#", "");
                theme.overlayColor = colors.surface.variant;
                theme.mutedColor = colors.surface.on_surface_variant;
                theme.subtleColor = colors.outline;
                theme.textColor = colors.surface.on_surface;
                theme.accentColor = colors.primary.base;
                theme.errorColor = colors.status.error;
                theme.outlineColor = colors.outline;
                
                console.log("Quickshell: Matugen theme applied successfully!");
            } catch (e) {
                console.warn("Quickshell: Failed to parse colors.json, using fallbacks colors.", e);
            }
        }
    }

    Component.onCompleted: {
        themeReader.read();
    }
}
