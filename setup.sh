#!/bin/bash

# Install required packages
sudo pacman -S --needed curl zsh vim neovim nodejs papirus-icon-theme

# Change shell for zsh
chsh -s /bin/zsh

# Install oh-my-zsh and plugins
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

[ ! -d 'powerlevel10k' ] && git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

[ ! -d 'zsh-autosuggestions' ] && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

[ ! -d 'zsh-syntax-highlighting' ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install vim-plug for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Copy SDDM config files
cp .config/sddm/default.conf /etc/sddm.conf.d/
git clone https://github.com/lwndhrst/sddm-rose-pine.git
cp -r sddm-rose-pine /usr/share/sddm/themes/
cp .config/sddm/theme.conf.user /usr/share/sddm/themes/sddm-rose-pine/
cp .config/sddm/blockwavemoon.png /usr/share/sddm/themes/sddm-rose-pine/

