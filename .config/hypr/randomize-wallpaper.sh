#!/bin/bash

# Check if we are running at login/startup
IS_INIT=false
if [[ "$1" == "--init" ]]; then
    IS_INIT=true
fi

WALLPAPER_DIR="$HOME/wallpapers/"

# ONLY filter out the current wallpaper if we are doing a mid-session manual swap
if [ "$IS_INIT" = false ] && [ -L "$HOME/.config/hypr/current_wallpaper.png" ]; then
    CURRENT_WALL=$(readlink -f "$HOME/.config/hypr/current_wallpaper.png")
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)
else
    # On login, grab a completely unrestricted random wallpaper instantly
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
fi

# Safety exit if directory is empty
[ -z "$WALLPAPER" ] && exit 1

# Create a permanent symlink pointing to the newly chosen wallpaper
ln -sf "$WALLPAPER" "$HOME/.config/hypr/current_wallpaper.png"

# Dynamic Color Injection (Happens BEFORE wallpaper renders on screen)
if command -v matugen &> /dev/null; then
    matugen image "$WALLPAPER" -m dark
    
    # Reload Kitty instances instantly on the fly
    kill -SIGUSR1 $(pgrep kitty) 2>/dev/null
fi

makoctl reload

# Set the wallpaper based on execution mode
if [ "$IS_INIT" = true ]; then
    # Force awww to override its automatic boot cache instantly
    awww img "$WALLPAPER" --transition-type none
else
    # INSTANT mid-session swap with the crisp, geometric wave transition
    awww img "$WALLPAPER" --transition-type wave --transition-angle 45 --transition-duration 1.5
fi
