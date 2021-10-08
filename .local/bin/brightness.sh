#!/bin/sh

bright=$(ddccontrol -r 0x10 -W $110 dev:/dev/i2c-6 | awk '/^Control/ {print $3}' | awk -F "/" '{print $2}')
bar=$(seq -s "🬋" $(($bright/5)) | sed 's/[0-9]//g')

$HOME/.local/bin/notify-send.py $bright"% "$bar -i "/usr/share/icons/Papirus/48x48/status/notification-display-brightness-full.svg" --replaces-process brightness
