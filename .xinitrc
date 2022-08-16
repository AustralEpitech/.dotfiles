#!/bin/sh

xrandr \
    --output HDMI-2 --auto --primary
    --output eDP-1 --left-of HDMI-2
exec x-window-manager
