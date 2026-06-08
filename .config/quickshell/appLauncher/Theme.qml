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

    function _updateTheme(data) {
        try {
            const parsed = JSON.parse(data);
            const c = parsed.colors || parsed; // Support both nested and flat JSON

            // Helper to safely get nested values or fallback to current property
            const get = (val, fallback) => val !== undefined ? val : fallback;

            backgroundColor = get(c.background, backgroundColor);
            transparentBackgroundColor = c.background ? "#E6" + c.background.replace("#", "") : transparentBackgroundColor;

            // Refined mapping for Material You structure
            overlayColor  = get(c.surface?.variant, get(c.surface_variant, overlayColor));
            mutedColor    = get(c.surface?.on_surface_variant, get(c.muted, mutedColor));
            subtleColor   = get(c.outline, subtleColor);
            textColor     = get(c.surface?.on_surface, get(c.on_background, textColor));
            accentColor   = get(c.primary?.base, get(c.primary, accentColor));
            errorColor    = get(c.status?.error, get(c.error, errorColor));
            outlineColor  = get(c.outline, outlineColor);

            console.log("Quickshell: Theme updated dynamically");
        } catch (e) {
            console.warn("Quickshell: Theme parse error:", e);
        }
    }

    FileView {
        id: themeReader
        path: Quickshell.shellDir + "/../colors.json"
        
        onTextChanged: {
            const content = String(themeReader.text());
            if (content.trim() !== "") {
                theme._updateTheme(content);
            }
        }
    }
}
