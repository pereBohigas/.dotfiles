#!/bin/zsh

[ ! -d "$HOME/.config/ghostty" ] && mkdir -p "$HOME/.config/ghostty"
ln -s "$PWD/config" "$HOME/.config/ghostty/config"

