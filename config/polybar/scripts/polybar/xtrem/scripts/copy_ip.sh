#!/usr/bin/env bash

FILE="$HOME/.config/polybar/xtrem/scripts/interface.conf"
interface="$(grep 'interface:' $FILE | cut -d ':' -f2 | tr -d '\t')"

echo -n $(/usr/sbin/ifconfig $interface 2>/dev/null | grep 'inet ' | awk '{print $2}') | xclip -sel c
