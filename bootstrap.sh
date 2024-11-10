#!/bin/zsh

### Customize output ###

# Define colors
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
#CURRENT_OPERATING_SYSTEM=$(uname -s)

if [ $(uname -s) == "Darwin" ]; then
	print_color GREEN "Running bootstrap for macOS"
else
	print_color GREEN "Running bootstrap "
fi

if [ "$CURRENT_OPERATING_SYSTEM" == "Darwin" ]; then
	print_color GREEN "Saving current system sleep time settings"

	CURRENT_COMPUTER_SLEEP_TIME=$(sudo systemsetup -getcomputersleep | grep -o -E '[0-9]+')
	CURRENT_DISPLAY_SLEEP_TIME=$(sudo systemsetup -getdisplaysleep | grep -o -E '[0-9]+')
	CURRENT_HARDDISK_SLEEP_TIME=$(sudo systemsetup -getharddisksleep | grep -o -E '[0-9]+')

	# Inhibit macOS entering into sleep mode
	# from: http://www.rawinfopages.com/mac/how-to-customise-power-settings-terminal-mac
	sudo systemsetup -setcomputersleep "Never"
	sudo systemsetup -setdisplaysleep "Never"
	sudo systemsetup -setharddisksleep "Never"
fi

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

## TODO: Delete existing versions of linked files

# Alacritty
[ ! -d "$HOME/.config/alacritty" ] && mkdir -p "$HOME/.config/alacritty"
create_symlink "$DOTFILES_PATH/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
create_symlink "$DOTFILES_PATH/alacritty/gruvbox_material_medium_dark.toml" "$HOME/.config/alacritty/gruvbox_material_medium_dark.toml"

# Amethyst
[ ! -d "$HOME/.config/amethyst" ] && mkdir -p "$HOME/.config/amethyst"
create_symlink "$DOTFILES_PATH/amethyst/amethyst.yml" "$HOME/.config/amethyst/amethyst.yml"

# Git
[ ! -d "$HOME/.config/git" ] && mkdir -p "$HOME/.config/git"
create_symlink "$DOTFILES_PATH/git/config" "$HOME/.config/git/config"
create_symlink "$DOTFILES_PATH/git/ams_config" "$HOME/.config/git/ams_config"
create_symlink "$DOTFILES_PATH/git/global_gitignore" "$HOME/.config/git/global_gitignore"

# GitUI
#[ ! -d "$HOME/.config/gitui" ] && mkdir -p "$HOME/.config/gitui"
#create_symlink "$DOTFILES_PATH/gitui/key_config.ron" "$HOME/.config/gitui/key_config.ron"

# Hammerspoon
# create_symlink "$HOME/.hammerspoon" "$DOTFILES_PATH/hammerspoon"

# Lazygit
[ ! -d "$HOME/.config/lazygit" ] && mkdir -p "$HOME/.config/lazygit"
create_symlink "$DOTFILES_PATH/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"

# Neovim
[ ! -d "$HOME/.config/nvim" ] && mkdir -p "$HOME/.config/nvim"
create_symlink "$DOTFILES_PATH/neovim/after" "$HOME/.config/nvim/after"
create_symlink "$DOTFILES_PATH/neovim/init.lua" "$HOME/.config/nvim/init.lua"
# create_symlink "$DOTFILES_PATH/neovim/init.vim" "$HOME/.config/nvim/init.vim"
create_symlink "$DOTFILES_PATH/neovim/lua" "$HOME/.config/nvim/lua"
create_symlink "$DOTFILES_PATH/neovim/spell" "$HOME/.config/nvim/spell"
create_symlink "$DOTFILES_PATH/vim/vimrc" "$HOME/.config/nvim/vimrc"

# SKHD
#[ ! -d "$HOME/.config/skhd" ] && mkdir "$HOME/.config/skhd"
#create_symlink "$DOTFILES_PATH/skhd/skhdrc" "$HOME/.config/skhd/skhdrc"

# SSH
[ ! -d "$HOME/.ssh" ] && mkdir "$HOME/.ssh"
create_symlink "$DOTFILES_PATH/ssh/config" "$HOME/.ssh/config"

# Vim
[ ! -d "$HOME/.vim" ] && mkdir "$HOME/.vim"
create_symlink "$DOTFILES_PATH/vim/vimrc" "$HOME/.vim/vimrc"

# Yabai
#[ ! -d "$HOME/.config/yabai" ] && mkdir "$HOME/.config/yabai"
#create_symlink "$DOTFILES_PATH/yabai/yabairc" "$HOME/.config/yabai/yabairc"

# Zellij
#[ ! -d "$HOME/.config/zellij" ] && mkdir -p "$HOME/.config/zellij"
#create_symlink "$DOTFILES_PATH/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"
#create_symlink "$DOTFILES_PATH/zellij/layouts" "$HOME/.config/zellij/layouts"
#create_symlink "$DOTFILES_PATH/zellij/themes" "$HOME/.config/zellij/themes"

# Zsh
create_symlink "$DOTFILES_PATH/zsh/zshenv" "$HOME/.zshenv"
[ ! -d "$HOME/.config/zsh" ] && mkdir -p "$HOME/.config/zsh"
create_symlink "$DOTFILES_PATH/zsh/zprofile" "$HOME/.config/zsh/.zprofile"
create_symlink "$DOTFILES_PATH/zsh/zshrc" "$HOME/.config/zsh/.zshrc"
create_symlink "$DOTFILES_PATH/zsh/zsh_aliases" "$HOME/.config/zsh/zsh_aliases"
create_symlink "$DOTFILES_PATH/shell_scripts/zsh_functions" "$HOME/.config/zsh/zsh_functions"
create_symlink "$DOTFILES_PATH/zsh/p10k.zsh" "$HOME/.config/zsh/p10k.zsh"
touch ~/.hushlogin # disable the “Last Login” message on new terminal session

### Create projects directories ###

print_color GREEN "Creating projects directories"

# TODO: Extract function for creating directories (if they do not exist?)

# Personal
[ ! -d "$HOME/Projects/personal_projects" ] && mkdir -p "$HOME/Projects/personal_projects"
create_symlink "$HOME/Projects/personal_projects" "$HOME/Projects/Personal Projects"

# TODO: Add documents directories

### Generate SSH keys ###

# Function to generate a passphrase with 128 bits of entropy
function generate_passphrase() {
	dd if=/dev/urandom bs=16 count=1 2>/dev/null | base64 | sed 's/=//g'
}

# Function to check if a SSH key is already added in the ssh agent
# $1: SSH key path
function is_key_already_in_agent() {
	if ssh-add -l | grep -q "$(ssh-keygen -lf $1 | awk '{print $2}')"; then
		# 0 = true
		return 0
	else
		# 1 = false
		return 1
	fi
}

# Function to generate a SSH key for a service
# $1: SSH key name
# $2: SSH key comment
function generate_ssh_key() {
	PASSPHRASE="$(generate_passphrase)"
	SSH_KEY_PATH="$HOME/.ssh/$1"

	# Generate SSH key if it does not exist
	if [ -f "$SSH_KEY_PATH" ]; then
		print_color RED "SSH key '$1' already exists"
	else
		print_color GREEN "Generating ssh key '$1'"
		ssh-keygen -t ed25519 -f "$SSH_KEY_PATH" -C "$2" -N "$PASSPHRASE"
	fi

	# Add ssh key to the ssh-agent if it is not already added
	if is_key_already_in_agent "$SSH_KEY_PATH"; then
		print_color RED "SSH key '$1' is already in the SSH agent"
	else
		print_color GREEN "Adding ssh key '$1'"
		touch "$HOME/.ssh/auto_ssh_key_add"

		chmod 700 "$HOME/.ssh/auto_ssh_key_add"

		cat >> "$HOME/.ssh/auto_ssh_key_add" <<-EOF
		#!/bin/sh
		echo $PASSPHRASE
		EOF

		chmod 500 "$HOME/.ssh/auto_ssh_key_add"

		# Set variables for auto adding of ssh key
		export DISPLAY=1
		export SSH_ASKPASS="$HOME/.ssh/auto_ssh_key_add"

		# Add ssh keys to the ssh-agent and therefore store passphrase in the keychain ('-K' option)
		ssh-add --apple-use-keychain "$SSH_KEY_PATH" < /dev/null

		rm -f "$HOME/.ssh/auto_ssh_key_add"
	fi
}

typeset -a SSH_SERVICES
while IFS= read -r LINE; do
	SSH_SERVICES+=("$LINE")
done < "$DOTFILES_PATH/ssh/ssh_services"

for SSH_SERVICE in "${SSH_SERVICES[@]}"; do
	# Add machine name to ssh key to avoid collision in Keychain
	# TODO: lowercase it
	MACHINE_NAME="$(hostname -s | tr '[:upper:]' '[:lower:]')"
	SSH_KEY_COMMENT="$MACHINE_NAME@$SSH_SERVICE"

	generate_ssh_key $SSH_SERVICE $SSH_KEY_COMMENT
done

# Set remote URL for the .dotfiles to use SSH

#git remote set-url origin git@gitlab.com:pereBohigas/.dotfiles.git

# proceed only for macOS
if [ "$CURRENT_OPERATING_SYSTEM" != "Darwin" ]; then
	exit 0
fi

### Install macOS command line tools ###

if xcode-select -p 1>/dev/null; then
	# install command line tools for Xcode
	xcode-select --install
fi

# Accept the Xcode license
sudo xcodebuild -license accept

# Fix error with xcode-select not pointing to a full regular Xcode
# source: https://stackoverflow.com/questions/17980759/xcode-select-active-developer-directory-error

# sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

### Install Homebrew ###

if ! command -v brew &> /dev/null; then
	print_color GREEN "Installing Homebrew"

	# download installation script using curl and run it
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew update --force --quiet

### Install Homebrew packages ###

print_color GREEN "Installing Homebrew packages"

brew bundle --file="$DOTFILES_PATH/homebrew/Brewfile" 2>/dev/null

### Update TeX Live packages ###

if command -v tlmgr &> /dev/null; then
	print_color GREEN "Updating TeX Live packages"

	sudo tlmgr update --self --all --reinstall-forcibly-removed
else
	print_color RED "TeX Live packages could not be updated"
fi

if [ "$CURRENT_OPERATING_SYSTEM" == "Darwin" ]; then
	print_color GREEN "Restore system sleep time settings"

	[ -v CURRENT_COMPUTER_SLEEP_TIME ] && sudo systemsetup -setcomputersleep "$CURRENT_COMPUTER_SLEEP_TIME"
	[ -v CURRENT_DISPLAY_SLEEP_TIME ] && sudo systemsetup -setdisplaysleep "$CURRENT_DISPLAY_SLEEP_TIME"
	[ -v CURRENT_HARDDISK_SLEEP_TIME ] && sudo systemsetup -setharddisksleep "$CURRENT_HARDDISK_SLEEP_TIME"
fi

