#!/bin/zsh

[ ! -d "$HOME/.config/alacritty" ] && mkdir -p "$HOME/.config/alacritty"
ln -s "$PWD/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
ln -s "$PWD/gruvbox_material_medium_dark.toml" "$HOME/.config/alacritty/gruvbox_material_medium_dark.toml"

