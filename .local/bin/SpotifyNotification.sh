#!/bin/sh
song=$(playerctl metadata | awk '/title/ {$1=$2="";print $0}')
artist=$(playerctl metadata | awk '/artist/ {$1=$2="";print $0}')
album=$(playerctl metadata | awk '{print $0}' | sed 's/albumArtist//;s/xesam://;s/mpris://' | sort -u | awk 'NR==1 {$1=$2="";print $0}')
thumb=$(playerctl metadata --format '{{lc(mpris:artUrl)}}')
convert "$thumb" -flatten -thumbnail 144x144 /home/hisham/.icons/thumb
dunstify -I "/home/hisham/.icons/thumb" "$song" "$artist" "$album"
