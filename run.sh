#!/bin/bash
ROOT=$(pwd)

config_list=(
    "$ROOT/nvim $HOME/.config/nvim"
    "$ROOT/wezterm $HOME/.config/wezterm"
    "$ROOT/zsh/.zshrc $HOME/.zshrc"
)

RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
RESET='\033[0m'

for config in "${config_list[@]}";
do
    source=$(echo $config | cut -d ' ' -f 1)
    target=$(echo $config | cut -d ' ' -f 2)

    echo "source = $source"
    echo "target = $target"

    target_dir=$(dirname "$target")
    mkdir -p "$target_dir"

    ln -sf "$source" "$target" && echo -e "${GREEN}Link: ${source} -> ${target}${RESET}"
done
