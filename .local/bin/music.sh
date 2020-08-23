#!/bin/sh

play_icon=""
pause_icon=""
cur_icon=""

if pgrep -x "mpd" >/dev/null
then
    play_info=$(mpc current)
    play_sts=$(mpc | awk '/\[/ {print $1}')

    if [[ "${play_sts}" = "[paused]" ]]; then
        cur_icon="${pause_icon}"

    elif [[ "${play_sts}" = "[playing]" ]]; then
        cur_icon="${play_icon}"

    fi

    printf "$cur_icon $play_info"

elif pgrep -x "spotifyd" >/dev/null
then
    player_sts=$(playerctl status)
    info_title=$(playerctl metadata title)
    info_album=$(playerctl metadata album)
    info_artist=$(playerctl metadata artist)

    if [[ "${player_sts}" = "Paused" ]]; then
        cur_icon="${pause_icon}"

    elif [[ "${player_sts}" = "Playing" ]]; then
        cur_icon="${play_icon}"

    fi

    printf "$cur_icon $info_artist - $info_title"

else
    exit 0
fi
