#!/bin/zsh

[ ! -d "$HOME/.config/televison" ] && mkdir -p "$HOME/.config/television"
ln -s "$PWD/config.toml" "$HOME/.config/television/config.toml"
ln -s "$PWD/default_channels.toml" "$HOME/.config/television/default_channels.toml"

