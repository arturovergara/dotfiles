#!/usr/bin/env bash

FILE="$HOME/.config/polybar/scripts/interface.conf"
interface="$(grep 'interface:' $FILE | cut -d ':' -f2 | tr -d '\t')"

if [ "$interface" == "tun0" ]; then
	icon="%{F#9FEF00}"
else
	icon="%{F#2CA2F5}"
fi

echo -e "$icon %{F#f1f1f1}$(/usr/sbin/ifconfig $interface 2>/dev/null | grep 'inet ' | awk '{print $2}')%{u-}"

