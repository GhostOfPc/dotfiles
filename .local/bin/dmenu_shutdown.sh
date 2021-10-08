#!/bin/sh

insidecolor=00000000
TDcolor=ffffff90
Rcolor=ffffff30
hlcolor=fa257360
verring=97e12360
actions=(Lock Logout Suspend Reboot Firmware Shutdown)

Selected=$(printf '%s\n' "${actions[@]}" | dmenu -i -p "Option:")

if [[ ! -z $Selected ]]; then
    answer="$(echo -e "Yes\nNo" | \
        dmenu -i -p "Are you sure?")"
    if [[ $answer == "Yes" ]]; then
        if [[ $Selected == "Suspend" ]]; then
            systemctl suspend
        elif [[ $Selected == "Lock" ]]; then
            betterlockscreen -u ~/Pictures/Nude/0056.jpg -b 3 -l blur
        elif [[ $Selected == "Logout" ]]; then
            killall Xorg
        elif [[ $Selected == "Reboot" ]]; then
            systemctl reboot
        elif [[ $Selected == "Firmware" ]]; then
            systemctl reboot --firmware-setup
        else
            shutdown -h now
        fi
    fi
fi
