#!/bin/sh

xrandr                                  \
    --output eDP-1 --auto --primary     \
    --output DP-1-2 --auto --pos 1920x0 \
    --output DP-1-3 --auto --pos 3840x0

exec dwm
