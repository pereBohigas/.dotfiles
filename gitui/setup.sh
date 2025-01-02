#!/bin/zsh

[ ! -d "$HOME/.config/gitui" ] && mkdir -p "$HOME/.config/gitui"
ln -s "$PWD/key_config.ron" "$HOME/.config/gitui/key_config.ron"

