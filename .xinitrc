#!/bin/sh

xrandr                                      \
    --output eDP-1 --auto --primary         \
    --output HDMI-2 --auto --right-of eDP-1

# fix touchscreen
xinput --map-to-output 'Raydium Corporation Raydium Touch System' 'eDP-1'

exec awesome
