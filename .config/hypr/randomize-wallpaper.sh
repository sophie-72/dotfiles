#!/usr/bin/env bash
set -euo pipefail

IS_INIT=false
if [[ "${1-}" == "--init" ]]; then
  IS_INIT=true
fi

WALLPAPER_DIR="$HOME/wallpapers"
LINK="$HOME/.config/hypr/current_wallpaper.png"

# Pick wallpaper
if [[ "$IS_INIT" == false && -L "$LINK" ]]; then
  current="$(readlink -f "$LINK" 2>/dev/null || true)"
  WALLPAPER="$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$current")" 2>/dev/null | shuf -n 1)"
else
  WALLPAPER="$(find "$WALLPAPER_DIR" -type f 2>/dev/null | shuf -n 1)"
fi

# Safety exit if directory is empty or selection failed
if [[ -z "${WALLPAPER:-}" ]]; then
  exit 1
fi

# Update symlink
ln -sf "$WALLPAPER" "$LINK"

# Generate colors (must be non-interactive)
if command -v matugen >/dev/null 2>&1; then
  matugen image "$WALLPAPER" -m dark --source-color-index 0
fi

# Reload apps that should pick up new colors
makoctl reload >/dev/null 2>&1 || true
if pgrep -x kitty >/dev/null 2>&1; then
  kill -SIGUSR1 "$(pgrep -x kitty | head -n 1)" 2>/dev/null || true
fi

# Set wallpaper
if [[ "$IS_INIT" == true ]]; then
  awww img "$WALLPAPER" --transition-type none
else
  awww img "$WALLPAPER" --transition-type wave --transition-angle 45 --transition-duration 1.5
fi

# If this is mid-session manual swap, restart QuickShell so it re-reads theme/colors
if [[ "$IS_INIT" == false ]]; then
  if pgrep -x quickshell >/dev/null 2>&1; then
    pkill -x quickshell
  fi
  command -v quickshell >/dev/null 2>&1 && quickshell &
fi
