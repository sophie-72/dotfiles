#!/bin/bash

# Check if we are running at login/startup
IS_INIT=false
if [[ "$1" == "--init" ]]; then
    IS_INIT=true
fi

WALLPAPER_DIR="$HOME/wallpapers/"

# Get the actual current wallpaper by reading where the symlink points
if [ -L "$HOME/.config/hypr/current_wallpaper.png" ]; then
    CURRENT_WALL=$(readlink -f "$HOME/.config/hypr/current_wallpaper.png")
else
    CURRENT_WALL=""
fi

# Get a random wallpaper that is not the current one
if [ -n "$CURRENT_WALL" ]; then
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)
else
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
    # Instant load on login—no transition animation
    awww img "$WALLPAPER" --transition-type none
else
    # INSTANT mid-session swap with the crisp, geometric wave transition
    awww img "$WALLPAPER" --transition-type wave --transition-angle 45 --transition-duration 1.5
fi
