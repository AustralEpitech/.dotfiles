#!/bin/sh

# keyboard
setxkbmap us altgr-intl
numlockx

# mouse
xinput set-prop 'pointer:Logitech G903' 'libinput Accel Profile Enabled' 0, 1

# touchpad
(
    DEV='PNP0C50:0e 06CB:7E7E Touchpad'

    xinput set-prop "$DEV" 'libinput Natural Scrolling Enabled' 1
    xinput set-prop "$DEV" 'libinput Tapping Enabled'           1
    xinput set-prop "$DEV" 'libinput Click Method Enabled'      0, 1
)

# display
xrandr                                                                \
    --output eDP-1  --pos 0x0    --mode 1920x1080 --rate 60 --primary \
    --output DisplayPort-1-2 --pos 1920x0 --auto                      \
    --output DisplayPort-1-1 --pos 3840x0 --auto

# startup
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
picom &
redshift &
feh --bg-tile "$XDG_CONFIG_HOME/wallpapers/landscape.png" --no-fehbg
nm-applet &
dunst &

xset dpms 300 15 # dim 5m, lock 5m15s
xss-lock lock &

#bar
(conky | while read LINE; do xsetroot -name "$LINE"; done) &

exec dwm
