#!/bin/sh

actions=(Suspend Reboot Shutdown)

Selected=$(printf '%s\n' "${actions[@]}" | dmenu -i -p "What do you wanna do?")

case "$Selected" in
    Suspend) systemctl suspend ;;
    Reboot) systemctl reboot ;;
    Shutdown) shutdown -h now ;;
esac
