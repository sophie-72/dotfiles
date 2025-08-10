# dotfiles
- Distro: [Arch](https://archlinux.org/)
- Shell: zsh + [Oh My Zsh](https://ohmyz.sh/) + [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- Text Editors: [vim](https://www.vim.org/) + [neovim](https://neovim.io/)
- Icons: [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
- Display Manager: [SDDM](https://github.com/sddm/sddm/)
- Compositor: [Hyprland](https://hyprland.org/)
- Bar: [Waybar](https://github.com/Alexays/Waybar)
- Application launcher: [Rofi](https://github.com/lbonn/rofi)
- Power menu: [Rofi Power Menu](https://github.com/jluttine/rofi-power-menu)
- Notification daemon: [Dunst](https://github.com/dunst-project/dunst)
- Terminal: [Kitty](https://github.com/kovidgoyal/kitty)
- Global theme: [Rosé Pine Moon](https://rosepinetheme.com/)
- Lock Screen Wallpaper: [https://github.com/rose-pine/wallpapers/blob/main/blockwavemoon.png](https://github.com/rose-pine/wallpapers/blob/main/blockwavemoon.png)

![](screenshots/Hyprland/SDDM.png)
![](screenshots/Hyprland/Desktop.png)
![](screenshots/Hyprland/Kitty.png)


## Clone the repository
```
git clone https://github.com/sophie-72/dotfiles.git
```

## Or clone the repository as a bare repository
**Warning**
This may overwrite existing files in your home directory. Please ensure you backup any important files before proceeding.

```
git clone --bare https://github.com/sophie-72/dotfiles.git $HOME/.dotfiles

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

dotfiles checkout

dotfiles config --local status.showUntrackedFiles no
```

## Setup
**Reboot after running the script**
```
chmod +x setup.sh

./setup.sh
```

## Replace the new .zshrc created by the Oh My Zsh installation by the old one
```
rm .zshrc

mv .zshrc.pre-oh-my-zsh .zshrc

source $HOME/.zshrc
```

## Enable SDDM
```
sudo systemctl enable sddm
```

## Reboot

