#!/bin/sh

artist=$(playerctl metadata --format '{{xesam:artist}}')
title=$(playerctl metadata --format '{{xesam:title}}')
album=$(playerctl metadata --format '{{xesam:album}}')
thumb=$(playerctl metadata --format '{{lc(mpris:artUrl)}}')
length=$(playerctl metadata --format '{{duration(mpris:length)}}')
convert "$thumb" -flatten -thumbnail 196x196 $HOME/.icons/thumb

notify-send "$(echo -e "Now Playing 🎵\n[Artist] $artist\n[Song] $title ($length)\n[Album] $album")" -i "$HOME/.icons/thumb" -t 10000
