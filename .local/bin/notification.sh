#!/bin/sh
metadata=$(playerctl metadata | awk '/title/;/artist/;/album/ {print}' | sed 's/spotifyd xesam://g'  | awk '$1 !~/albumArtist/ {print}' | sort -b -r | awk '{$1="";print $0}') 
thumb=$(playerctl metadata --format '{{lc(mpris:artUrl)}}')
convert "$thumb" -flatten -thumbnail 96x96 $HOME/.icons/thumb
playerctl metadata | awk '/title/;/artist/;/album/ {print}' | sed 's/spotifyd xesam://g'  | awk '$1 !~/albumArtist/ {print}' | sort -b -r | awk '{print}' >> $HOME/.spotify_log
echo "════════════════════════════════════════════════════════════════════════════════" >> $HOME/.spotify_log
sleep 2
notify-send -i "$HOME/.icons/thumb" "$metadata" -t 8000

