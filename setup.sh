#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Installing Paru (AUR Helper)"
if ! command -v paru &> /dev/null; then
    sudo pacman -S --needed base-devel git
    mkdir -p /tmp/paru-build
    git clone https://aur.archlinux.org/paru.git /tmp/paru-build/paru
    cd /tmp/paru-build/paru
    makepkg -si --noconfirm
    cd -
fi


echo -e "\nInstalling required packages"
paru -S --needed \
    jq curl zsh helix openssh papirus-icon-theme \
    sddm awww hyprland hypridle hyprlock \
    xdg-desktop-portal-hyprland hyprpolkitagent xdg-utils \
    udiskie kitty qt5-base qt6-5compat quickshell \
    matugen mako vim wireplumber brightnessctl playerctl \
    otf-font-awesome grim slurp wl-clipboard zen-browser-bin \
    bluez bluez-utils pipewire pipewire-pulse pipewire-alsa pipewire-audio pavucontrol


echo "Setting the locale to en_US.UTF-8"
sudo localectl set-locale LANG=en_US.UTF-8


echo -e "\nInstalling oh-my-zsh and plugins"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended

    ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
    git clone https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

    echo 'export EDITOR="helix"' >> ~/.zshrc
    echo 'export VISUAL="helix"' >> ~/.zshrc
fi


echo -e "\nStarting and enabling bluetooth"
sudo systemctl enable --now bluetooth


echo -e "\nEnabling audio stacks (Pipewire + Wireplumber)"
systemctl --user enable --now pipewire pipewire-pulse wireplumber


echo -e "\nConfiguring SDDM Login Environment"
curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh
