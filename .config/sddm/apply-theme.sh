#!/bin/bash

CURRENT_WALL=$(awww query | grep -oE '/.*' || echo "")

SDDM_THEME_DIR="/usr/share/sddm/themes/sugar-candy"

if [ -f "$HOME/.config/sddm/theme.conf" ]; then
    sudo cp "$HOME/.config/sddm/theme.conf" "$SDDM_THEME_DIR/theme.conf"
fi

if [ -f "$CURRENT_WALL" ]; then
    sudo cp "$CURRENT_WALL" "$SDDM_THEME_DIR/Backgrounds/current_wall.png"
fi
