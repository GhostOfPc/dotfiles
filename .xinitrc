#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
res=$(xrandr --listmonitors | awk 'NR==3 {print $3}' | awk -F "/" '{print $1}')

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

# Detect if a second monitor is connected or no 
#if [ -n "$res" ]; then
#    xrandr --output HDMI-A-0 --scale 2.0x2.0 --right-of HDMI-A-1
#fi

# Autostart useful programs
~/.fehbg &
#blurwal -m 1 -b 30 -s 15 &
~/.local/bin/prayerTimes.sh &
#barriers -a :24800 --daemon --no-tray --name Studio --disable-crypto -c $HOME/.local/share/barrier/.barrier.conf &
udiskie &
lxqt-policykit-agent &
xfce4-power-manager &
picom --experimental-backends &
#pushbullet &
#nextcloud &
#tint2 &
#exec dbus-launch xfce4-session
exec awesome
#exec openbox-session
