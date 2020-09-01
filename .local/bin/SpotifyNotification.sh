#!/bin/sh

thumb=$(playerctl metadata --format '{{lc(mpris:artUrl)}}')
convert "$thumb" -flatten -thumbnail 144x144 $HOME/.icons/thumb.png

info=$(playerctl metadata --format '{{uc(status)}} {{emoji(status)}}|{{xesam:artist}}|{{xesam:title}}|{{xesam:album}}'| awk -F "|" '{printf  "<span size=\"large\" fgcolor=\"#dfd460\"><b>"$1"</b></span>\n<span fgcolor=\"#fa2573\"><b>[Artist] </b></span>"$2"\n<span fgcolor=\"#97e123\"><b>[Title] </b></span>"$3"\n<span fgcolor=\"#0f7fcf\"><b>[Album] </b></span>"$4}')
notify-send "$info" -i "$HOME/.icons/thumb.png" -t 10000


