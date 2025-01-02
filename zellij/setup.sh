#!/bin/zsh

[ ! -d "$HOME/.config/zellij" ] && mkdir -p "$HOME/.config/zellij"
ln -s "$PWD/config.kdl" "$HOME/.config/zellij/config.kdl"
ln -s "$PWD/themes" "$HOME/.config/zellij/themes"

