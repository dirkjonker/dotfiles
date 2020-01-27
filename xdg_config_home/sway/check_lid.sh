#!/bin/bash

set +x
set +e

cat /proc/acpi/button/lid/LID/state | grep closed

if [ $? -eq 0 ]
then
    echo 'lid is closed'
    swaymsg output eDP-1 disable
else
    echo 'lid is open'
fi
