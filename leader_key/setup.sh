#!/bin/zsh

LEADER_KEY_CONFIG_FILE_DIRECTORY="$HOME/Library/Application Support/Leader Key"
LEADER_KEY_CONFIG_FILE_PATH="$LEADER_KEY_CONFIG_FILE_DIRECTORY/config.json"

[ ! -d "$LEADER_KEY_CONFIG_FILE_DIRECTORY" ] && echo "Leader Key App not installed" && exit 1
rm -f "$LEADER_KEY_CONFIG_FILE_PATH"
ln -s "$PWD/config.json" "$LEADER_KEY_CONFIG_FILE_PATH"

