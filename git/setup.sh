#!/bin/zsh

[ ! -d "$HOME/.config/git" ] && mkdir -p "$HOME/.config/git"
ln -s "$PWD/additional_config" "$HOME/.config/git/additional_config"
ln -s "$PWD/config" "$HOME/.config/git/config"
ln -s "$PWD/global_gitignore" "$HOME/.config/git/global_gitignore"
ln -s "$PWD/global_template" "$HOME/.config/git/global_template"

