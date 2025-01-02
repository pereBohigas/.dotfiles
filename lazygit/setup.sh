#!/bin/zsh

[ ! -d "$HOME/.config/lazygit" ] && mkdir -p "$HOME/.config/lazygit"
ln -s "$PWD/config.yml" "$HOME/.config/lazygit/config.yml"

