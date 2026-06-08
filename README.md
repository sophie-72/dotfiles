# dotfiles
- Distro: [Arch](https://archlinux.org/)
- Shell: zsh + [Oh My Zsh](https://ohmyz.sh/) + [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- Text Editor: [Helix](https://helix-editor.com/)
- Display Manager: [SDDM](https://github.com/sddm/sddm/)
- Compositor: [Hyprland](https://hyprland.org/)
- Bar, Power Menu & Application Launcher: [Quickshell](https://quickshell.org/)
- Notification Daemon: [Mako](https://github.com/emersion/mako)
- Terminal: [Kitty](https://github.com/kovidgoyal/kitty)


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

