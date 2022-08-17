#!/bin/sh

#xrandr                               \
#    --output HDMI-2 --auto --primary \
#    --output eDP-1 --left-of HDMI-2
#
## fix touchscreen
#xinput --map-to-output 'Raydium Corporation Raydium Touch System' 'eDP-1'

exec x-window-manager
