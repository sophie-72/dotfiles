sudo apt-get update
sudo apt-get install curl git zsh

chsh -s /bin/zsh

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

git clone https://github.com/zsh-users/zsh-autosuggestions \
${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo
echo
echo "Make the following changes in ~/.zshrc"
echo 'Change the value of ZSH_THEME to ZSH_THEME="powerlevel10k/powerlevel10k"'
echo "Change the line that starts with plugins= to plugins=(git zsh-syntax-highlighting zsh-autosuggestions)"
echo
echo "After these changes, run 'source ~/.zshrc' Powerlevel10k's configuration wizard should start automatically; enter 'p10k configure' if it doesn't."
