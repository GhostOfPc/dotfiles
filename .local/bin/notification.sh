#!/bin/sh
metadata=$(playerctl metadata | awk '/title/;/artist/;/album/ {print}' | sed 's/spotifyd xesam://g'  | awk '$1 !~/albumArtist/ {print}' | sort -b -r | awk '{$1="";print $0}') 
thumb=$(playerctl metadata --format '{{lc(mpris:artUrl)}}')
convert "$thumb" -flatten -thumbnail 144x144 $HOME/.icons/thumb
playerctl metadata | awk '/title/;/artist/;/album/ {print}' | sed 's/spotifyd xesam://g'  | awk '$1 !~/albumArtist/ {print}' | sort -b -r | awk '{print}' >> $HOME/.spotify_log
echo "════════════════════════════════════════════════════════════════════════════════" >> $HOME/.spotify_log
sleep 2
dunstify -I "$HOME/.icons/thumb" "$metadata" -t 8000
