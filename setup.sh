#!/bin/bash

# Detect the OS (either Linux, Mac OS)
OS="$(uname)"

# Detect the linux distribution
PACKAGE_MANAGER=""

if [ "$OS" == "Linux" ]; then
    # Check if it's Ubuntu or Arch Linux
    if [ -x "$(command -v apt-get)" ]; then
        PACKAGE_MANAGER="apt-get"
    elif [ -x "$(command -v pacman)" ]; then
        PACKAGE_MANAGER="pacman"
    fi

    if [ "$PACKAGE_MANAGER" == "apt-get" ]; then
        sudo apt-get update
        sudo apt-get install curl zsh neofetch vim neovim
    elif [ "$PACKAGE_MANAGER" == "pacman" ]; then
        sudo pacman -Sy
        sudo pacman -S curl zsh neofetch vim neovim nodejs npm code
    fi
elif [ "$OS" == "Darwin" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install curl zsh neofetch vim neovim node
fi

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
