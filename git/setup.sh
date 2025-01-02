#!/bin/zsh

[ ! -d "$HOME/.config/git" ] && mkdir -p "$HOME/.config/git"
ln -s "$PWD/ams_config" "$HOME/.config/git/ams_config"
ln -s "$PWD/config" "$HOME/.config/git/config"
ln -s "$PWD/global_gitignore" "$HOME/.config/git/global_gitignore"

