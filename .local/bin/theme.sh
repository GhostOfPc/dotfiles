#!/bin/sh

option=$(echo -e "Dark\nLight" | dmenu -i -p 'What theme you want to apply?')

if [[ $option == "Dark" ]]; then
    sed -i '/^beautiful.init/s/Lighttheme/Darktheme/' $HOME/.config/awesome/rc.lua
    sed -i 's/theme=MateriaLight/theme=MateriaDark/' $HOME/.config/Kvantum/kvantum.kvconfig
    sed -i '/^gtk-th/s/light/dark/' $HOME/.config/gtk-2.0/gtkrc
    sed -i '/^gtk-th/s/light/dark/' $HOME/.config/gtk-3.0/settings.ini
    sed -i '/^background_opacity/s/0.30/0.80/ ; /^foreground/s/#202020/#DEDCE4/ ; /^background/s/#DEDCE4/#202020/ ; /^cursor /s/#111111/#bbbbbb/ ; /^cursor_t/s/#bbbbbb/#111111/' $HOME/.config/kitty/kitty.conf
    sed -i '166s/dedce4/202020/ ; 167s/202020/dedce4/' $HOME/.config/alacritty/alacritty.yml
    sed -i 's/set background/"set background/' $HOME/.vimrc
    sed -i 's/set background/"set background/' $HOME/.config/nvim/init.vim
    sed -i '/^playbar_background/s/DarkGray/Black/ ; s/text: Black/text: White/' $HOME/.config/spotify-tui/config.yml
    
    cd $HOME/.config/dmenu
    rm -f config.h
	sed -i 's/\[SchemeNorm\] = { "#202020", "#f5f5f5"}/\[SchemeNorm\] = { "#f5f5f5", "#202020"}/ ; s/\[SchemeNormHighlight\] = { "#9e4e85", "#f5f5f5" }/\[SchemeNormHighlight\] = { "#9e4e85", "#202020" }/ ; s/\[SchemeSel\] = { "#e5b566", "#d3d3d3"/\[SchemeSel\] = { "#e5b566", "#505050"/' config.def.h
    sudo make clean install

    echo 'awesome.restart()' | awesome-client

    sleep 1
    notify-send "🌜 Dark theme applied" -t 2000
elif [[ $option == "Light" ]]; then
    sed -i '/^beautiful.init/s/Darktheme/Lighttheme/' $HOME/.config/awesome/rc.lua
    sed -i 's/theme=MateriaDark/theme=MateriaLight/' $HOME/.config/Kvantum/kvantum.kvconfig
    sed -i 's/gtk-theme-name="Materia-dark"/gtk-theme-name="Materia-light"/' $HOME/.config/gtk-2.0/gtkrc
    sed -i 's/gtk-theme-name=Materia-dark/gtk-theme-name=Materia-light/' $HOME/.config/gtk-3.0/settings.ini
    sed -i '/^background_opacity/s/0.80/0.30/ ; /^foreground/s/#DEDCE4/#202020/ ; /^background/s/#202020/#DEDCE4/ ; /^cursor /s/#bbbbbb/#111111/ ; /^cursor_t/s/#111111/#bbbbbb/' $HOME/.config/kitty/kitty.conf
    sed -i '166s/#202020/#dedce4/ ; 167s/#dedce4/#202020/' $HOME/.config/alacritty/alacritty.yml
    sed -i 's/"set background/set background/' $HOME/.vimrc
    sed -i 's/"set background/set background/' $HOME/.config/nvim/init.vim
    sed -i '/^playbar_background/s/Black/DarkGray/ ; s/text: White/text: Black/' $HOME/.config/spotify-tui/config.yml
    
    cd $HOME/.config/dmenu
    rm -f config.h
	sed -i 's/\[SchemeNorm\] = { "#f5f5f5", "#202020"}/\[SchemeNorm\] = { "#202020", "#f5f5f5"}/ ; s/\[SchemeNormHighlight\] = { "#9e4e85", "#202020" }/\[SchemeNormHighlight\] = { "#9e4e85", "#f5f5f5" }/ ; s/\[SchemeSel\] = { "#e5b566", "#505050"/\[SchemeSel\] = { "#e5b566", "#d3d3d3"/' config.def.h
    sudo make clean install

    echo 'awesome.restart()' | awesome-client

    sleep 1
    notify-send "☀️  Light theme applied" -t 2000
else
    exit
fi
