#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# Autostart useful programs
#blurwal -m 1 -b 30 -s 15 &
#~/.local/bin/prayerTimes.sh &
#barriers -a :24800 --daemon --no-tray --name Studio --disable-crypto -c $HOME/.local/share/barrier/.barrier.conf &
#nextcloud &
#tint2 &
#xfce4-power-manager &
~/.fehbg &
lxqt-policykit-agent &
volctl &
#blueman-applet &
picom &
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY & # Required for flatpaks with no DE
emacs --daemon &
exec awesome
#exec i3
#exec dbus-launch xfce4-session
#exec openbox-session
