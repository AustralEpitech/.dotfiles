#!/bin/sh

xrandr                                      \
    --output eDP-1 --auto --primary         \
    --output HDMI-A-1 --auto --right-of eDP-1

exec awesome
