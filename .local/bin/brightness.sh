#!/usr/bin/env bash

# You can call this script like this:
# $ ./brightnessControl.sh up
# $ ./brightnessControl.sh down

# Script inspired by these wonderful people:
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

function get_brightness {
  xbacklight -get | cut -d '.' -f 1
}

function send_notification {
  icon="/usr/share/icons/Papirus-Dark/symbolic/status/display-brightness-medium-symbolic.svg"
  brightness=$(get_brightness)
  # Make the bar with the special character ─ (it's not dash -)
  # https://en.wikipedia.org/wiki/Box-drawing_character
  bar=$(seq -s "━" 0 $((brightness / 5)) | sed 's/[0-9]//g')
  # Send the notification
  dunstify "$brightness"" %   ""$bar" -i "$icon" -h int:value:"$brightness" -r 444
}

case $1 in
  up)
    # increase the backlight by 2%
    xbacklight -inc 2
    send_notification
    ;;
  down)
    # decrease the backlight by 2%
    xbacklight -dec 2
    send_notification
    ;;
esac
