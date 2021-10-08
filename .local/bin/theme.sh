#!/bin/sh

option=$(echo -e "Dark\nLight" | dmenu -i -p 'What theme you want to apply?')

if [[ $option == "Dark" ]]; then
    sed -i '/^beautiful.init/s/Lighttheme/Darktheme/' $HOME/.config/awesome/rc.lua
    sed -i '/icons_dir/s/Light/Dark/' $HOME/.config/awesome/widgets/WEATHER_WIDGET.lua
    sed -i '/clock_icon/s/light/dark/' $HOME/.config/awesome/widgets/WEATHER_WIDGET.lua
    sed -i '/theme/s/Light/Dark/' $HOME/.config/Kvantum/kvantum.kvconfig
    sed -i '/theme/s/Light/Dark/' $HOME/.config/qt5ct/qt5ct.conf
    sed -i '/^gtk-th/s/light/dark/' $HOME/.config/gtk-2.0/gtkrc
    sed -i '/^gtk-th/s/light/dark/' $HOME/.config/gtk-3.0/settings.ini
    sed -i '/^gtk-th/s/light/dark/' $HOME/.config/gtk-4.0/settings.ini
    cp $HOME/.config/kitty/dark.conf $HOME/.config/kitty/kitty.conf
    cp $HOME/.config/alacritty/dark.yml $HOME/.config/alacritty/alacritty.yml
    sed -i '/background/s/light/dark/' $HOME/.vimrc
    sed -i '/background/s/light/dark/' $HOME/.config/nvim/init.vim
    sed -i '/^playbar_background/s/DarkGray/Black/ ; s/text: Black/text: White/' $HOME/.config/spotify-tui/config.yml
    
    cd $HOME/.config/dmenu
    rm -f config.h
    cp $HOME/.config/dmenu/dark.h $HOME/.config/dmenu/config.def.h
    sudo make clean install

    echo 'awesome.restart()' | awesome-client

    sleep 1
    notify-send "🌜 Dark theme applied" -t 2000
elif [[ $option == "Light" ]]; then
    sed -i '/^beautiful.init/s/Darktheme/Lighttheme/' $HOME/.config/awesome/rc.lua
    sed -i '/icons_dir/s/Dark/Light/' $HOME/.config/awesome/widgets/WEATHER_WIDGET.lua
    sed -i '/clock_icon/s/dark/light/' $HOME/.config/awesome/widgets/WEATHER_WIDGET.lua
    sed -i '/theme/s/Dark/Light/' $HOME/.config/Kvantum/kvantum.kvconfig
    sed -i '/theme/s/Dark/Light/' $HOME/.config/qt5ct/qt5ct.conf
    sed -i '/^gtk-th/s/dark/light/' $HOME/.config/gtk-2.0/gtkrc
    sed -i '/^gtk-th/s/dark/light/' $HOME/.config/gtk-3.0/settings.ini
    sed -i '/^gtk-th/s/dark/light/' $HOME/.config/gtk-4.0/settings.ini
    cp $HOME/.config/kitty/light.conf $HOME/.config/kitty/kitty.conf
    cp $HOME/.config/alacritty/light.yml $HOME/.config/alacritty/alacritty.yml
    sed -i '/background/s/dark/light/' $HOME/.vimrc
    sed -i '/background/s/dark/light/' $HOME/.config/nvim/init.vim
    sed -i '/^playbar_background/s/Black/DarkGray/ ; s/text: White/text: Black/' $HOME/.config/spotify-tui/config.yml
    
    cd $HOME/.config/dmenu
    rm -f config.h
    cp $HOME/.config/dmenu/light.h $HOME/.config/dmenu/config.def.h
    sudo make clean install

    echo 'awesome.restart()' | awesome-client

    sleep 1
    notify-send "☀️  Light theme applied" -t 2000
else
    exit
fi
