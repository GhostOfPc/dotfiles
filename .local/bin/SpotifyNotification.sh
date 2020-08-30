#!/bin/sh

thumb=$(playerctl metadata --format '{{lc(mpris:artUrl)}}')
convert "$thumb" -flatten -thumbnail 144x144 $HOME/.icons/thumb

info=$(playerctl metadata --format '{{uc(status)}} {{emoji(status)}}|{{xesam:artist}}|{{xesam:title}}|{{xesam:album}}'| awk -F "|" '{printf  "<span foreground=\"#dfd460\"><b><big>"$1"</big></b></span>\n<span foreground=\"#fa2573\"><b>[Artist] </b></span>"$2"\n<span foreground=\"#97e123\"><b>[Title] </b></span>"$3"\n<span foreground=\"#0f7fcf\"><b>[Album] </b></span>"$4}')
notify-send "$info" -i "$HOME/.icons/thumb" -t 10000


