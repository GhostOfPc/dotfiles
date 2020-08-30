#!/bin/sh

play_icon=""
pause_icon=""
cur_icon=""

if pgrep -x "spotifyd" >/dev/null
then
    song_info=$(playerctl metadata --format '{{emoji(status)}} {{duration(position)}}[{{duration(mpris:length)}}] {{xesam:artist}} - {{xesam:title}}')

    printf "$song_info"

elif pgrep -x "mpd" >/dev/null
then
    play_info=$(mpc current)
    play_sts=$(mpc | awk '/\[/ {print $1}')

    if [[ "${play_sts}" = "[paused]" ]]; then
        cur_icon="${pause_icon}"

    elif [[ "${play_sts}" = "[playing]" ]]; then
        cur_icon="${play_icon}"

    fi

    echo "$cur_icon $play_info"

else
    exit 0
fi
