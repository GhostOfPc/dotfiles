#!/bin/sh

actions=(Lock Logout Suspend Reboot Shutdown)

Selected=$(printf '%s\n' "${actions[@]}" | dmenu -i -p "What do you wanna do?")

if [[ ! -z $Selected ]]; then
    answer="$(echo -e "Yes\nNo" | \
        dmenu -i -p "Are you sure?")"
    if [[ $answer == "Yes" ]]; then
        if [[ $Selected == "Suspend" ]]; then
            systemctl suspend
        elif [[ $Selected == "Lock" ]]; then
            i3lock --clock -i $HOME/.icons/lockscreen.jpg --timecolor=ffffffff --datecolor=ffffffff --timesize=100 --datesize=30 --timepos="250:950"
        elif [[ $Selected == "Logout" ]]; then
            killall $WM
        elif [[ $Selected == "Reboot" ]]; then
            systemctl reboot
        else
            shutdown -h now
        fi
    fi
fi
