#!/bin/bash

# Install required packages
sudo pacman -Sy
sudo pacman -S curl zsh neofetch vim neovim nodejs npm papirus-icon-theme
yay -Sy
yay -S kwin-bismuth latte-dock-git lightlyshaders-git

# Change shell for zsh
chsh -s /bin/zsh

# Install oh-my-zsh and plugins
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

git clone https://github.com/zsh-users/zsh-autosuggestions \
${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install vim-plug for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Setup grub theme
git clone https://github.com/vinceliuice/grub2-themes.git
sudo ./install.sh -b -t stylish
