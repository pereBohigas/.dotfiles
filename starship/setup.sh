#!/bin/zsh

[ ! -d "$HOME/.config/starship" ] && mkdir -p "$HOME/.config/starship"
ln -s "$PWD/starship.toml" "$HOME/.config/starship/starship.toml"
# TODO: Add setting of environment variable into `zshenv` (../zsh/zshenv) -> export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
# TODO: Add prompt initialization into `zshrc` (../zsh/zshrc) -> eval "$(starship init zsh)"

