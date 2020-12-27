#!/bin/sh

# Get some parameters like the location and the school to be used
# when calculating the fajr and isha angle
city="Bariloche"
country="Argentina"
method="3" #option 3 means Muslim World League

rm $HOME/.local/share/prayers.json
# The api can be found for free
curl "http://api.aladhan.com/v1/timingsByCity?city=$city&country=$country&method=$method" -s -o $HOME/.local/share/prayers.json

