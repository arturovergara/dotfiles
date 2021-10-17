#!/usr/bin/env bash

SDIR="$HOME/.config/polybar/scripts"
FILE="$SDIR/interface.conf"

change_interface()
{
	echo -e "interface:\t$1" > $FILE
}

# Launch Rofi
MENU="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '' \
-theme $SDIR/rofi/interface.rasi \
<<< " Ens33| VPN")"
            case "$MENU" in
				*Ens33) change_interface "ens33" ;;
				*VPN) change_interface "tun0" ;;
            esac
