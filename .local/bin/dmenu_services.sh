#!/bin/sh

list=(smb ssh flood nordvpn jellyfin)
actions=(smb sshd flood nordvpnd jellyfin)

selected=$(printf '%s\n' "${list[@]}" | dmenu -i -p "Services: ")

for i in "${!list[@]}"; do
    if [ ! -z "$selected" ] && [[ "${list[$i]}" = $selected ]]; then
        action="$(echo -e "Start\nStop\nStatus" | \
            dmenu -i -p "Start/Stop service:")"
        if [[ $action == "Start" ]]; then
            systemctl start "${actions[i]}"
        elif [[ $action == "Stop" ]]; then
            systemctl stop "${actions[i]}"
        else
            $TERMINAL --hold -e systemctl status "${actions[i]}"
        fi
    fi
done
