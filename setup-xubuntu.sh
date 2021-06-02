#!/bin/sh
# Run this from ~

# TODO: 
# - consolidate apt install commands
# - add autostart commands programmatically
# - install chrome via command line

# Vim + dotfiles
sudo apt-get update
sudo apt -y upgrade
sudo apt install -y git vim 

mkdir ~/.trash
mkdir -p ~/.vim/undodir

ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
mkdir -p ~/.config/nvim/
ln -s ~/dotfiles/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.gitignore ~/.gitignore

# VS Code Insiders
sudo apt update
sudo apt install -y software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt install -y code-insiders

# Neovim for VS Code
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract

# Python
sudo apt install -y python3.9 python3.9-venv python3-pip

# Start-up stuff
sudo apt-get install -y xfce4-appmenu-plugin xcape
# Add below to autostart
synclient VertScrollDelta=-30
xcape -e 'Super_L=Control_L|Escape'

# Discord
sudo -E gpg --no-default-keyring --keyring=/usr/share/keyrings/javinator9889-ppa-keyring.gpg --keyserver keyserver.ubuntu.com --recv-keys 08633B4AAAEB49FC
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/javinator9889-ppa-keyring.gpg] https://ppa.javinator9889.com all main" | sudo tee /etc/apt/sources.list.d/javinator9889-ppa.list
sudo apt update && sudo apt install -y discord

# Microsoft Teams
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" > /etc/apt/sources.list.d/teams.list'
sudo apt update && sudo apt install -y teams

# Spotify
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install -y spotify-client

# Rest
sudo apt install -y simplescreenrecorder vlc blueman bluez bluetooth fonts-noto-color-emoji mousepad

# Fish
sudo apt install -y fish
chsh -s /usr/bin/fish

# Do Manually
# - Install chrome
# - Turn compositor off (for performance)
# - Super-arrow shortcuts for window placement
# - Adwaita icons
# - Greybird dark style
# - Jetbrains mono fonts (https://www.jetbrains.com/lp/mono/)
# - UI Font: ubuntu
# - Remove text from panel (leave icons)
# - Set up monitor profile
# - Pair bluetooth devices
# - Log into: VSCode, Teams, Slack, Discord, Chrome, Spotify
# - Open to set up: Vim, Neovim