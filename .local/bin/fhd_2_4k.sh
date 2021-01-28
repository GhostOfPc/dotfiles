#!/bin/sh

res=$(xrandr --listmonitors | awk 'NR==2 {print $3}' | awk -F "/" '{print $1}')

if [ $res -eq 1920 ]; then
    sed -i '/dpi/s/130/240/' $HOME/.Xresources
    sed -i '/gears.shape.rounded/s/6/8/ ; /forced_width/s/3/8/' $HOME/.config/awesome/widgets.lua
    sed -i '/bottom_bar.y/s/1050/2105/ ; /s.top_bar.y/s/3/6/' $HOME/.config/awesome/bottom_bar.lua
    sed -i '/forced_width/s/100/200/ ; /forced_height/s/100/200/' $HOME/.config/awesome/Prayers_widget.lua
    sed -i '/c.zoom.default/s/110/250/' $HOME/.config/qutebrowser/config.py
    #sed -i '/corner-radius/s/10.0/20.0/ ; /round-borders/s/10.0/20.0/' $HOME/.config/picom/picom.conf

    cd $HOME/.config/dmenu
    rm -f config.h
    sed -i '/ lineheight /s/27/50/ ; /xoffset/s/5/10/ ; /yoffset/s/3/6/ ; /max_width/s/1910/3820/' config.def.h
    sudo make clean install
else
    sed -i '/dpi/s/240/130/' $HOME/.Xresources
    sed -i '/gears.shape.rounded/s/8/6/ ; /forced_width/s/8/3/' $HOME/.config/awesome/widgets.lua
    sed -i '/bottom_bar.y/s/2105/1050/ ; /s.top_bar.y/s/6/3/' $HOME/.config/awesome/bottom_bar.lua
    sed -i '/forced_width/s/200/100/ ; /forced_height/s/200/100/' $HOME/.config/awesome/Prayers_widget.lua
    sed -i '/c.zoom.default/s/250/110/' $HOME/.config/qutebrowser/config.py
    #sed -i '/corner-radius/s/20.0/10.0/ ; /round-borders/s/20.0/10.0/' $HOME/.config/picom/picom.conf

    cd $HOME/.config/dmenu
    rm -f config.h
    sed -i '/ lineheight /s/50/27/ ; /xoffset/s/10/5/ ; /yoffset/s/6/3/ ; /max_width/s/3820/1910/' config.def.h
    sudo make clean install
fi

killall $WM
