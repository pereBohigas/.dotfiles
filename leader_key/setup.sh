#!/bin/zsh

[ ! -d "$HOME/.config/leader_key" ] && mkdir -p "$HOME/.config/leader_key"
ln -s "$PWD/config.json" "$HOME/.config/leader_key/config.json"

