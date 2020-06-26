#!/bin/sh
# Simple bash script for displaying the current temperature, humidity and precipitation, if wttr.in i unavailable then WEATHER UNAVAILABLE will be displayed

weather=$(curl -s wttr.in/Bariloche?format=%C+%c+%t)

if [ $(echo "$weather" | grep -E "(Unknown|curl|HTML)" | wc -l) -gt 0 ]; then
    echo "N/A"
else
    echo "$weather" | awk '{print $0}'
fi

