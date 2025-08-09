#!/bin/bash

# Install Paru
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..

# Install required packages
paru -S --needed curl zsh vim neovim nodejs papirus-icon-theme sddm hyprland waybar rofi-wayland rofi-power-menu dunst kitty

# Change shell for zsh
chsh -s /bin/zsh

# Install oh-my-zsh and plugins
[ ! -d ~/.oh-my-zsh ] && sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

[ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k ] && git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ] && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install vim-plug for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Copy SDDM config files
sudo mkdir /etc/sddm.conf.d/
sudo cp .config/sddm/default.conf /etc/sddm.conf.d/
[ ! -d "sddm-rose-pine" ] && git clone https://github.com/lwndhrst/sddm-rose-pine.git
sudo cp -r sddm-rose-pine /usr/share/sddm/themes/
sudo cp .config/sddm/theme.conf.user /usr/share/sddm/themes/sddm-rose-pine/
sudo cp .config/sddm/blockwavemoon.png /usr/share/sddm/themes/sddm-rose-pine/

