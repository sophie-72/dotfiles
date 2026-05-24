#!/usr/bin/env bash

sleep 3

WALLPAPER_DIR="$HOME/wallpapers/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

# Apply the selected wallpaper
hyprctl hyprpaper wallpaper ", $WALLPAPER"

# Dynamic Color Injection
if command -v matugen &> /dev/null; then
    matugen image "$WALLPAPER" -m dark
    
    # Reload Kitty instances instantly on the fly
    kill -SIGUSR1 $(pgrep kitty) 2>/dev/null
fi

makoctl reload
