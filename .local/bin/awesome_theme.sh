#!/bin/sh

theme=$(ls ~/.config/awesome/themes/colorschemes | dmenu -i -l 5 -g 10 -p "Select a theme: ")

[ -z "$theme" ] && exit
sed -i "17s/'.*'/'$theme'/" ~/.config/awesome/themes/theme.lua

if [[ $theme == *"Dark"* ]] || [[ $theme == *"Night"* ]] || [[ $theme == "Molokai" ]] || [[ $theme == "Argonaut" ]] || [[ $theme == "Encom" ]]; then
    sed -i '6s/Light/Dark/ ; 7s/light/dark/' ~/.config/awesome/widgets/WEATHER_WIDGET.lua
    sed -i '4s/light/dark/ ; 5s/Light/Dark/' ~/.gtkrc-2.0
    sed -i '2s/light/dark/ ; 3s/Light/Dark/' ~/.config/gtk-3.0/settings.ini
    printf "[General]\ntheme=VimixRubyDark" > ~/.config/Kvantum/kvantum.kvconfig
    sed -i '4s/Light/Dark/' ~/.config/qt5ct/qt5ct.conf
    sed -i '24s/lighter/darker/' ~/.config/nvim/init.vim
    kitty +kitten themes Material Dark

    cd ~/.config/dmenu
    rm -f config.h
    sed -i '17s/light/dark/' config.def.h
    sudo make clean install

else
    sed -i '6s/Dark/Light/ ; 7s/dark/light/' ~/.config/awesome/widgets/WEATHER_WIDGET.lua
    sed -i '4s/dark/light/ ; 5s/Dark/Light/' ~/.gtkrc-2.0
    sed -i '2s/dark/light/ ; 3s/Dark/Light/' ~/.config/gtk-3.0/settings.ini
    printf "[General]\ntheme=VimixRuby" > ~/.config/Kvantum/kvantum.kvconfig
    sed -i '4s/Dark/Light/' ~/.config/qt5ct/qt5ct.conf
    sed -i '24s/darker/lighter/' ~/.config/nvim/init.vim
    kitty +kitten themes Material

    cd ~/.config/dmenu
    rm -f config.h
    sed -i '17s/dark/light/' config.def.h
    sudo make clean install

fi
echo 'awesome.restart()' | awesome-client
