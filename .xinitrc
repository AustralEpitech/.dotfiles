#!/bin/sh

# keyboard
setxkbmap us altgr-intl

# mouse
(
    PROP='libinput Accel Profile Enabled'

    for id in $(xinput list --id-only); do
        xinput set-prop "$id" "$PROP" 0, 1 2> /dev/null
    done
)

# display
xrandr                                           \
    --output eDP-1 --auto --primary              \
    --output DisplayPort-1-2 --auto --pos 1920x0 \
    --output DisplayPort-1-1 --auto --pos 3840x0

exec dwm
