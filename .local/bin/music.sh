#!/bin/sh

if pgrep -x "mpv" >/dev/null
then
    title=$(playerctl metadata --format '{{emoji(status)}} {{duration(position)}}[{{duration(mpris:length)}}] {{xesam:title}}')
    printf "$title"

elif pgrep -x "vlc" >/dev/null
then
    title=$(playerctl metadata --format '{{emoji(status)}} {{duration(position)}}[{{duration(mpris:length)}}] {{xesam:title}}')
    printf "$title"

elif pgrep -x "spotifyd" >/dev/null
then
    song_info=$(playerctl metadata --format '{{emoji(status)}} {{duration(position)}}[{{duration(mpris:length)}}] {{xesam:artist}} - {{xesam:title}}')

    printf "$song_info"

elif pgrep -x "mpd" >/dev/null
then
    play_info=$(mpc current)
    play_sts=$(mpc | awk '/\[/ {print $1}')
	play_pos=$(mpc | awk '/\[/ {print $3}' | awk -F "/" '{print $1 "[" $2 "]"}')
    if [[ "${play_sts}" = "[paused]" ]]; then
        cur_icon="⏸️"

    elif [[ "${play_sts}" = "[playing]" ]]; then
        cur_icon="▶️"

    fi

    echo "$cur_icon $play_pos $play_info"

else
    exit 0
fi
