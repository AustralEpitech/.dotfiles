#!/bin/sh

xrandr                               \
    --output eDP-1 --primary         \
    --output HDMI-2 --right-of-eDP-1

exec awesome
