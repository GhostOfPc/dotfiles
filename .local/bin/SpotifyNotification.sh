#!/bin/sh

thumb=$(playerctl metadata --format '{{lc(mpris:artUrl)}}')
convert "$thumb" -flatten -thumbnail 256x256 /tmp/thumb.png

info=$(playerctl metadata --format '{{uc(status)}} {{emoji(status)}}|{{xesam:artist}}|{{xesam:title}}|{{xesam:album}}'| awk -F "|" '{printf  "<span size=\"large\" fgcolor=\"#e5b566\"><b>"$1"</b></span>\n<span fgcolor=\"#ac4142\"><b>[Artist] </b></span>"$2"\n<span fgcolor=\"#7e8d50\"><b>[Title] </b></span>"$3"\n<span fgcolor=\"#6c99ba\"><b>[Album] </b></span>"$4}')
notify-send "$info" -i "/tmp/thumb.png" -t 10000
rm /tmp/thumb.png
