#!/bin/zsh

[ ! -d "$HOME/.config/skhd" ] && mkdir -p "$HOME/.config/skhd"
ln -s "$PWD/skhdrc" "$HOME/.config/skhd/skhdrc"

