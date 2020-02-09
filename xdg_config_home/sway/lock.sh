#!/bin/bash

wallpapers="${HOME}/Pictures/wallpapers/shipping"
image="$(ls ${wallpapers} | shuf | head -n1)"

swaylock --image "${wallpapers}/${image}" & /usr/bin/sleep 1
