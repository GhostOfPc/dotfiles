#!/bin/sh

actions=(Login Logout Connect Disconnect Status)

selected=$(printf '%s\n' "${actions[@]}" | dmenu -i -p "Action: ")

case "$selected" in
	Login) nordvpn login ;;
	Logout) nordvpn logout ;;
	Connect) nordvpn connect Brazil ;;
	Disconnect) nordvpn disconnect ;;
	Status) sts=$(nordvpn status) 
		notify-send "$sts" -t 10000
		;;
esac
