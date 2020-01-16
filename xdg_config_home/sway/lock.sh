#!/bin/bash

wallpapers="${HOME}/Pictures/wallpapers"

image=$(ls ${wallpapers} | shuf | head -n1)

swaylock --image ${wallpapers}/${image}
