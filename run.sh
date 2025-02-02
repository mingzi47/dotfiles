#!/bin/bash
ROOT=$(pwd)

config_list=(
    "$ROOT/nvim $HOME/.config/nvim"
    "$ROOT/wezterm $HOME/.config/wezterm"
    "$ROOT/fish $HOME/.config/fish"
    # "$ROOT/zsh/.zshrc $HOME/.zshrc"
)

RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
RESET='\033[0m'

LN_COMMAND="ln"
if [[ "$(uname -s)" == "Darwin" ]]; then
	LN_COMMAND="gln"
	config_list+=("$ROOT/sketchybar $HOME/.config/sketchybar")
fi

for config in "${config_list[@]}";
do
    source_path=$(echo $config | cut -d ' ' -f 1)
    target_path=$(echo $config | cut -d ' ' -f 2)

    target_dir=$(dirname "$target_path")
    mkdir -p "$target_dir"

    $LN_COMMAND -sfTv $source_path $target_path  | awk -F"'" -v green="$GREEN" -v reset="$RESET" '{printf "%s%s -> %s%s\n", green, $4, $2, reset}'
done
