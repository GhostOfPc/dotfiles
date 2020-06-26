#!/bin/sh

actions=(awesomeRC awesomeTh awesomeAps xmonadC xmobar ranger picom dunst)

selected=$(printf '%s\n' "${actions[@]}" | dmenu -i -p "Action: ")

case "$selected" in
	awesomeRC) $TERMINAL nvim $HOME/.config/awesome/rc.lua ;;
	awesomeAps) $TERMINAL nvim $HOME/.config/awesome/apps.lua ;;
	awesomeTh) $TERMINAL nvim $HOME/.config/awesome/themes/theme.lua ;;
	xmonadC) $TERMINAL nvim $HOME/.xmonad/xmonad.hs ;;
	xmobar) $TERMINAL nvim $HOME/.config/xmobar/xmobarrc ;;
	ranger) $TERMINAL nvim $HOME/.config/ranger/rc.conf ;;
	picom) $TERMINAL nvim $HOME/.config/picom/picom.conf ;;
	dunst) $TERMINAL nvim $HOME/.config/dunst/dunstrc;;
esac
