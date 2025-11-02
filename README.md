# dotfiles
- Distro: [Arch](https://archlinux.org/)
- Shell: zsh + [Oh My Zsh](https://ohmyz.sh/) + [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- Text Editor: [Helix](https://helix-editor.com/)
- Display Manager: [SDDM](https://github.com/sddm/sddm/)
- Compositor: [Hyprland](https://hyprland.org/)
- Bar: [Quickshell](https://quickshell.org/)
- Application launcher: [Rofi](https://github.com/lbonn/rofi)
- Power menu: [Rofi Power Menu](https://github.com/jluttine/rofi-power-menu)
- Notification daemon: [Dunst](https://github.com/dunst-project/dunst)
- Terminal: [Kitty](https://github.com/kovidgoyal/kitty)
- Global theme: [Rosé Pine Moon](https://rosepinetheme.com/)
- Lock Screen Wallpaper: [https://github.com/rose-pine/wallpapers/blob/main/blockwavemoon.png](https://github.com/rose-pine/wallpapers/blob/main/blockwavemoon.png)


## Clone the repository as a bare repository

**Warning:** This may overwrite existing files in your home directory. Please ensure you back up any important files before proceeding.

```
git clone --bare https://github.com/sophie-72/dotfiles.git $HOME/.dotfiles

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

dotfiles checkout

dotfiles config --local status.showUntrackedFiles no
```

## Setup

1. Run the setup script:

```
./setup.sh
```

2. Reboot your system

