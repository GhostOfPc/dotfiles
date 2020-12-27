#!/bin/sh

nextprayer=""
prayers="$HOME/.local/share/prayers.json"

# The api can be found for free
#salawat=$(curl "https://api.pray.zone/v2/times/today.json?city=$city&school=$school" -s)

# Parsing the data for the five salawat
fajr=$(jq ".data.timings.Fajr" $prayers | bc | awk '{$1=$1};1')
dhuhr=$(jq ".data.timings.Dhuhr" $prayers | bc | awk '{$1=$1};1')
asr=$(jq ".data.timings.Asr" $prayers | bc | awk '{$1=$1};1')
maghrib=$(jq ".data.timings.Maghrib" $prayers | bc | awk '{$1=$1};1')
isha=$(jq ".data.timings.Isha" $prayers | bc | awk '{$1=$1};1')


# Sending the salawat to the stdout
printf "🕌 مواقيت الصلاة\nالفجر   ۞ $fajr\nالظهر   ۞ $dhuhr\nالعصر   ۞ $asr\nالمغرب ۞ $maghrib\nالعشاء  ۞ $isha"
