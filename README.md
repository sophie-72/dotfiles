# dotfiles

## Overview
- Distro: [Arch](https://archlinux.org/)
- DE: [Plasma](https://kde.org/plasma-desktop/)
- WM: KWin
- Grub Theme ([source](https://github.com/vinceliuice/grub2-themes)): Tela
- Shell: zsh + [Oh My Zsh](https://ohmyz.sh/) + [Powerlevel10k](https://github.com/romkatv/powerlevel10k)

## Clone the repository
```
git clone https://github.com/0xSP3C14LN1NJ4/dotfiles.git
```

## Or clone the repository as a bare repository
**Warning**
It may overwrites existing files in your home directory. Please ensure to backup any important files before proceeding.

```
git clone --bare https://github.com/0xSP3C14LN1NJ4/dotfiles.git $HOME/.dotfiles

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

source $HOME/.zshrc

dotfiles checkout

dotfiles config --local status.showUntrackedFiles no
```

## Setup
```
chmod +x setup.sh

./setup.sh
```
