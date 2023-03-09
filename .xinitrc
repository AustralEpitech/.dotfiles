#!/bin/sh

# keyboard
numlockx

# display
xrandr                                           \
    --output eDP-1           --auto  --primary   \
    --output DisplayPort-1-1 --auto --pos 1920x0 \
    --output DisplayPort-1-2 --auto --pos 3840x0

# startup
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
picom &
redshift &
feh --bg-tile "$XDG_CONFIG_HOME/wallpapers/landscape.png" --no-fehbg
dunst &
sbar &

xset dpms 300 # lock 5m
xss-lock -- lock &

exec dbus-launch dwm
