#!/bin/sh

artist=$(playerctl metadata --format '{{xesam:artist}}')
title=$(playerctl metadata --format '{{xesam:title}}')
album=$(playerctl metadata --format '{{xesam:album}}')
thumb=$(playerctl metadata --format '{{lc(mpris:artUrl)}}')
convert "$thumb" -flatten -thumbnail 144x144 $HOME/.icons/thumb

notify-send "$(echo -e "Now Playing 🎵\n[Artist] $artist\n[Song] $title\n[Album] $album")" -i "$HOME/.icons/thumb" -t 10000
