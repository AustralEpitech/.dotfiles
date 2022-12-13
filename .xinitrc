#!/bin/sh

xrandr                              \
    --output eDP-1 --auto --primary \
    --output HDMI-2 --auto --pos 1920x0

# fix touchscreen
xinput --map-to-output 'Raydium Corporation Raydium Touch System' 'eDP-1'

exec awesome
