#!/bin/bash

echo "Installing Paru"
if ! pacman -Qi paru > /dev/null; then
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
    cd ..
fi

echo "Installing required packages"
paru -S --needed curl zsh vim neovim nodejs papirus-icon-theme sddm hyprland waybar rofi-wayland rofi-power-menu dunst kitty

echo "Changing shell for zsh"
zsh_shell=/usr/bin/zsh
current_shell=$(cat /etc/passwd | grep `cd; pwd` | awk -F: '{print $7}')
if [[ "$zsh_shell" != "$current_shell" ]]; then
    chsh -s /usr/bin/zsh
fi

echo "Installing oh-my-zsh and plugins"
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

echo "Installing vim-plug for neovim"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "Copying SDDM config files"
sudo mkdir -p /etc/sddm.conf.d/
sudo cp .config/sddm/default.conf /etc/sddm.conf.d/
[ ! -d "sddm-rose-pine" ] && git clone https://github.com/lwndhrst/sddm-rose-pine.git
sudo cp -r sddm-rose-pine /usr/share/sddm/themes/
sudo cp .config/sddm/theme.conf.user /usr/share/sddm/themes/sddm-rose-pine/
sudo cp .config/sddm/blockwavemoon.png /usr/share/sddm/themes/sddm-rose-pine/

