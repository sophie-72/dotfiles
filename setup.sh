#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Installing Paru (AUR Helper)"
if ! command -v paru &> /dev/null; then
    sudo pacman -S --needed --noconfirm base-devel git
    mkdir -p /tmp/paru-build
    git clone https://aur.archlinux.org/paru.git /tmp/paru-build/paru

    # Using a subshell () keeps directory changes isolated
    (
        cd /tmp/paru-build/paru
        makepkg -si --noconfirm
    )
    # Automatically back in the original directory here
    rm -rf /tmp/paru-build
fi

echo -e "\nInstalling required packages"
paru -S --needed --noconfirm \
    jq curl zsh helix openssh papirus-icon-theme \
    less man-db man-pages \
    sddm awww hyprland hypridle hyprlock \
    xdg-desktop-portal-hyprland hyprpolkitagent xdg-utils \
    udiskie kitty qt5-base qt6-5compat quickshell \
    matugen mako vim wireplumber brightnessctl playerctl \
    otf-font-awesome grim slurp wl-clipboard zen-browser-bin \
    bluez bluez-utils pipewire pipewire-pulse pipewire-alsa pipewire-audio pavucontrol

echo "Setting the locale to en_CA.UTF-8"
sudo localectl set-locale LANG=en_CA.UTF-8

echo -e "\nInstalling oh-my-zsh and plugins"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

    rm .zshrc
    mv .zshrc.pre-oh-my-zsh .zshrc
fi

if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to zsh..."
    sudo chsh -s "$(which zsh)"
fi

# Zen Browser Theme
touch ~/.config/zen/zen-theme.css
PROFILE_DIR="$(find "$HOME/.config/zen" -maxdepth 1 -type d -name '*.Default (release)' 2>/dev/null | head -n1)"
CHROME_DIR="$PROFILE_DIR/chrome"
mkdir -p "$CHROME_DIR"
ln -sf "$HOME/.config/zen/zen-theme.css" "$CHROME_DIR/userChrome.css"

echo -e "\nStarting and enabling bluetooth"
sudo systemctl enable --now bluetooth

echo -e "\nEnabling audio stacks (Pipewire + Wireplumber)"
systemctl --user enable --now pipewire pipewire-pulse wireplumber

echo -e "\nConfiguring SDDM Login Environment"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"
