#!/bin/sh

theme=$(ls ~/.config/awesome/themes/colorschemes | dmenu -i -l 5 -g 10 -p "Select a theme: ")

[ -z "$theme" ] && exit

sed -i "17s/'.*'/'$theme'/" ~/.config/awesome/themes/theme.lua

echo 'awesome.restart()' | awesome-client
