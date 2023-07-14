#!/usr/bin/bash

pwd=$(pwd);

CONFIG1="$HOME/.config"
CONFIG2="$HOME"

config1=("nvim" "wezterm");
config2=("zsh/.zshrc")

link() {
  for e in ${config1[@]}; do
    target="$CONFIG1/$e"
    src="$pwd/$e"
    ln -sF $src $target
    echo "$src -> $target"
  done

  for e in ${config2[@]}; do
    target="$CONFIG2/${e#*/}"
    src="$pwd/$e"
    ln -sF $src $target
    echo "$src -> $target"
  done
}


isMac=$(uname -a | grep Darwin)
isLinux=$(uname -a | grep Linux)

if [[ $isMac != "" ]] ; then
  echo "OS : Mac OS !"
  link
elif [[ $isLinux != "" ]]; then
  echo "OS : Linux !"
fi

