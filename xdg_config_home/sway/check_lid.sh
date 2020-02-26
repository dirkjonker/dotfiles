#!/bin/bash

set +x
set +e

numscreens="$(swaymsg -t get_outputs  | jq '. | length')"

cat /proc/acpi/button/lid/LID/state | grep closed

if [ $? -eq 0 ]
then
    echo 'lid is closed'
    swaymsg output eDP-1 disable

    if [ $numscreens -eq '1' ]; then /usr/bin/systemctl suspend; fi
else
    echo 'lid is open'
    swaymsg output eDP-1 enable
fi
