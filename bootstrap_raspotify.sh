#!/bin/bash

# call with ./bootstrap_raspotify.sh

# TODO: Make it Bash compatible

### Customize output ###

# Define colors
# TODO: Colors not working on bash
GREEN='\033[0;32m'
RED='\033[0;31m'

# Function to print messages in color and set terminal output to no color after
# $1: color, from the predefined ones or an ANSI escape code
# $2: text to output
function print_color() {
	echo "${!1}${2}\033[0m"
}

# Get sudo privileges
sudo -v

DOTFILES_PATH=$(cd "$(dirname "$0")"; pwd -P)
CURRENT_OPERATING_SYSTEM=$(uname -s)

if [ $(uname -s) == "Linux" ]; then
	print_color GREEN "Running bootstrap for Raspberry Pi"
else
	print_color RED "Error: not running on a Linux distro"
	exit 1
fi

### Update Linux packages

print_color GREEN "Updating packages"

sudo apt update && sudo apt -y upgrade

### Create symbolic links for configuration files ###

print_color GREEN "Creating links for configuration files"

# Function to create a symlink if not already exists
# $1: target path
# $2: link path
function create_symlink() {
	if [ ! -L "$2" ]; then
		ln -s "$1" "$2"
		echo "Symlink '$2' created"
	fi
}

# GitUI
[ ! -d "$HOME/.config/gitui" ] && mkdir -p "$HOME/.config/gitui"
create_symlink "$DOTFILES_PATH/gitui/key_config.ron" "$HOME/.config/gitui/key_config.ron"

# Neovim
[ ! -d "$HOME/.config/nvim" ] && mkdir -p "$HOME/.config/nvim"
create_symlink "$DOTFILES_PATH/vim/vimrc" "$HOME/.config/nvim/vimrc"
create_symlink "$DOTFILES_PATH/neovim/init.vim" "$HOME/.config/nvim/init.vim"
create_symlink "$DOTFILES_PATH/neovim/spell" "$HOME/.config/nvim/spell"

# Vim
[ ! -d "$HOME/.vim" ] && mkdir "$HOME/.vim"
create_symlink "$DOTFILES_PATH/vim/vimrc" "$HOME/.vim/vimrc"

# Git
# [ ! -d "$HOME/.config/git" ] && mkdir -p "$HOME/.config/git"
# create_symlink "$DOTFILES_PATH/git/config" "$HOME/.config/git/config"
# create_symlink "$DOTFILES_PATH/git/oth_config" "$HOME/.config/git/oth_config"
# create_symlink "$DOTFILES_PATH/git/uoc_config" "$HOME/.config/git/uoc_config"

# Zsh
create_symlink "$DOTFILES_PATH/zsh/zshenv" "$HOME/.zshenv"
[ ! -d "$HOME/.config/zsh" ] && mkdir -p "$HOME/.config/zsh"
# TODO: .zprofile probably not needed
# create_symlink "$DOTFILES_PATH/zsh/zprofile" "$HOME/.config/zsh/.zprofile"
create_symlink "$DOTFILES_PATH/zsh/zshrc" "$HOME/.config/zsh/.zshrc"
create_symlink "$DOTFILES_PATH/zsh/zsh_aliases" "$HOME/.config/zsh/zsh_aliases"
create_symlink "$DOTFILES_PATH/zsh/zsh_functions" "$HOME/.config/zsh/zsh_functions"

### Install packages ###

print_color GREEN "Installing packages"

# Install Zsh
sudo apt install zsh -y
sudo apt install zsh-autosuggestions -y
sudo apt install zsh-syntax-highlighting -y

# Clone plugin not installable with apt
sudo git clone https://github.com/jeffreytse/zsh-vi-mode.git /usr/opt/zsh-vi-mode/share/zsh-vi-mode
# TODO: Source zsh-autosuggestions and zsh-syntax-highlighting

# [autosuggestions]="/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
# [syntax_highlighting]="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# [fzf_completion]="/usr/share/doc/fzf/examples/completion.zsh"
# [fzf_key_bindings]="/usr/share/doc/fzf/examples/key-bindings.zsh"
# [vi_mode]="/usr/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
# [prompt_theme]="/usr/share/powerlevel9k/powerlevel9k.zsh-theme"

# Set Zsh as default shell
sudo -s
chsh -s /bin/zsh root
chsh -s /bin/zsh pi

# Reboot needed

# Install vim
sudo apt install vim -y

# Install Neovim
sudo apt install neovim -y

# Install Exa
sudo apt install exa -y

# Install Fzf
sudo apt install fzf -y

sudo apt install powerlevel9k -y

# Install PowerLevel9k
sudo apt install zsh-theme-powerlevel9k -y

# Set ssh
# Create authorized_keys files in .ssh directory
mkdir .ssh
touch .ssh/authorized_keys
# Fill up with public keys of current machines
# ssh-ed25519 <public_key> <machine_name>@raspotify

# Tools required for Raspotify
sudo apt install curl -y

# Install Raspotify
# https://github.com/dtcooper/raspotify
curl -sL https://dtcooper.github.io/raspotify/install.sh | sh

# Config Raspotify
# sudo nvim /etc/raspotify/conf

# Set USB sound card as default sound card
sudo nvim /usr/share/alsa/alsa.conf

# ...
# defaults.ctl.card 0 -> 1
# defaults.pcm.card 0 -> 1
# ...

# To apply changes to the raspotify configuration
sudo systemctl restart raspotify

# Install Shairport-Sync
# https://github.com/mikebrady/shairport-sync
# https://appcodelabs.com/7-easy-steps-to-apple-airplay-on-raspberry-pi
sudo apt install shairport-sync

