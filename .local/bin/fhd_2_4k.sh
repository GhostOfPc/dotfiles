#!/bin/sh

resolution=(3840x2160 1920x1080)
selected=$(printf '%s\n' "${resolution[@]}" | dmenu -i -p "Select your desired resolution ")

if [ $selected = "3840x2160" ]; then
    sed -i '/dpi/s/96/144/' $HOME/.Xresources
    #sed -i '/corner-radius/s/10.0/20.0/ ; /round-borders/s/10.0/20.0/' $HOME/.config/picom/picom.conf

    cd $HOME/.config/dmenu
    rm -f config.h
    sed -i '/ lineheight /s/23/50/ ; /xoffset/s/5/10/ ; /yoffset/s/2/4/ ; /max_width/s/1910/3820/' config.def.h
    sudo make clean install > /dev/null 2>&1 &
else
    sed -i '/dpi/s/144/96/' $HOME/.Xresources
    #sed -i '/corner-radius/s/20.0/10.0/ ; /round-borders/s/20.0/10.0/' $HOME/.config/picom/picom.conf

    cd $HOME/.config/dmenu
    rm -f config.h
    sed -i '/ lineheight /s/50/23/ ; /xoffset/s/10/5/ ; /yoffset/s/4/2/ ; /max_width/s/3820/1910/' config.def.h
    sudo make clean install > /dev/null 2>&1 &
fi

xrdb -merge $HOME/.Xresources
echo 'awesome.restart()' | awesome-client
