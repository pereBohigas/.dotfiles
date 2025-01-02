#!/bin/zsh

[ ! -d "$HOME/.config/yabai" ] && mkdir -p "$HOME/.config/yabai"
ln -s "$PWD/yabairc" "$HOME/.config/yabairc"

