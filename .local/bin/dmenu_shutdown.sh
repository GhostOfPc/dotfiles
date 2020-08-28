#!/bin/sh

insidecolor=00000000
TDcolor=ffffff90
Rcolor=ffffff30
hlcolor=fa257360
verring=97e12360
actions=(Lock Logout Suspend Reboot Shutdown)

Selected=$(printf '%s\n' "${actions[@]}" | dmenu -i -p "What do you wanna do?")

if [[ ! -z $Selected ]]; then
    answer="$(echo -e "Yes\nNo" | \
        dmenu -i -p "Are you sure?")"
    if [[ $answer == "Yes" ]]; then
        if [[ $Selected == "Suspend" ]]; then
            systemctl suspend
        elif [[ $Selected == "Lock" ]]; then
            i3lock --clock -i $HOME/.icons/lockscreen.jpg --pass-media-keys \
                --timecolor=$TDcolor --datecolor=$TDcolor --timesize=100 \
                --datesize=20 --timepos="1700:850" --insidecolor=$insidecolor \
                --insidevercolor=$insidecolor --ringcolor=$Rcolor --line-uses-inside \
                --separatorcolor=$insidecolor --keyhlcolor=$hlcolor \
                --ringvercolor=$verring --insidewrongcolor=$hlcolor \
                --ringwrongcolor=$hlcolor \
                --datestr="(%A) %d %B %Y" --timestr="%H:%M"
        elif [[ $Selected == "Logout" ]]; then
            killall $WM
        elif [[ $Selected == "Reboot" ]]; then
            systemctl reboot
        else
            shutdown -h now
        fi
    fi
fi
