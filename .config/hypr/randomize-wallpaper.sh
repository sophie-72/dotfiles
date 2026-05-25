#!/usr/bin/env bash

sleep 3

WALLPAPER_DIR="$HOME/wallpapers/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

# Create a permanent symlink pointing to the newly chosen wallpaper
ln -sf "$WALLPAPER" "$HOME/.config/hypr/current_wallpaper.png"

# Dynamic Color Injection
if command -v matugen &> /dev/null; then
    matugen image "$WALLPAPER" -m dark
    
    # Reload Kitty instances instantly on the fly
    kill -SIGUSR1 $(pgrep kitty) 2>/dev/null
fi

makoctl reload

# Set the wallpaper with a crisp, geometric wave transition
awww img "$WALLPAPER" --transition-type wave --transition-angle 45 --transition-duration 1.5
