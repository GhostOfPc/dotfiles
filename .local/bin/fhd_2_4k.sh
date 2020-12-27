#!/bin/sh

res=$(xrandr --listmonitors | awk 'NR==2 {print $3}' | awk -F "/" '{print $1}')

if [ $res -eq 1920 ]; then
    sed -i '/dpi/s/120/240/' $HOME/.Xresources
    sed -i '/gears.shape.rounded/s/6/8/ ; /forced_width/s/3/8/' $HOME/.config/awesome/widgets.lua
    sed -i '/height = dpi/s/24/20/ ; s/s.bottom_bar.y = 1046/s.bottom_bar.y = 2105/' $HOME/.config/awesome/bottom_bar.lua
    sed -i '/corner-radius/s/10.0/20.0/ ; /round-borders/s/10.0/20.0/' $HOME/.config/picom/picom.conf

    cd $HOME/.config/dmenu
    rm -f config.h
    sed -i '/ lineheight /s/25/50/' config.def.h
    sudo make clean install
else
    sed -i '/dpi/s/240/120/' $HOME/.Xresources
    sed -i '/gears.shape.rounded/s/8/6/ ; /forced_width/s/8/3/' $HOME/.config/awesome/widgets.lua
    sed -i '/height = dpi/s/20/24/ ; s/s.bottom_bar.y = 2105/s.bottom_bar.y = 1046/' $HOME/.config/awesome/bottom_bar.lua
    sed -i '/corner-radius/s/20.0/10.0/ ; /round-borders/s/20.0/10.0/' $HOME/.config/picom/picom.conf

    cd $HOME/.config/dmenu
    rm -f config.h
    sed -i '/ lineheight /s/50/25/' config.def.h
    sudo make clean install
fi
killall $WM
