#!/bin/bash

echo "Installing Paru"
if ! pacman -Qi paru > /dev/null; then
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
    cd ..
fi

echo -e "\nInstalling required packages"
paru -S --needed curl zsh vim neovim nodejs npm papirus-icon-theme sddm hyprland hyprpaper hypridle hyprlock xdg-desktop-portal-hyprland hyprpolkitagent udiskie waybar rofi-wayland rofi-power-menu dunst kitty qt5-base qt5-graphicaleffects qt5-quick3d qt5-quickcontrols qt5-quickcontrols2 otf-font-awesome grim slurp wl-clipboard

echo -e "\nInstalling oh-my-zsh and plugins"
echo "IMPORTANT: Type 'exit' after the Oh My Zsh installation to allow this script to continue."
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

echo -e "\nCopying SDDM config files"
sudo mkdir -p /etc/sddm.conf.d/
sudo cp .config/sddm/default.conf /etc/sddm.conf.d/
[ ! -d "sddm-rose-pine" ] && git clone https://github.com/lwndhrst/sddm-rose-pine.git
sudo cp -r sddm-rose-pine /usr/share/sddm/themes/
sudo cp .config/sddm/theme.conf.user /usr/share/sddm/themes/sddm-rose-pine/
sudo cp .config/sddm/blockwavemoon.png /usr/share/sddm/themes/sddm-rose-pine/

