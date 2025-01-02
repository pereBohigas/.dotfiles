#!/bin/zsh

[ ! -d "$HOME/.ssh" ] && mkdir -p "$HOME/.ssh"
ln -s "$PWD/config" "$HOME/.ssh/config"
chmod 600 config # Give read and write permissions to the current user only (strict permissions) due to abuse potential

