#!/bin/sh

# keyboard
numlockx

# display
(
    LAPTOP_SCREEN="$(xrandr --listmonitors | grep eDP | awk '{print $4}')"

    xrandr                                                               \
        --output "${LAPTOP_SCREEN}" --mode 1920x1080 --rate 60 --primary
#        --output DisplayPort-1-1 --auto --pos 1920x0                      \
#        --output DisplayPort-1-2 --auto --pos 3840x0
)

# startup
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
picom &
redshift &
feh --bg-tile "$XDG_CONFIG_HOME/wallpapers/landscape.png" --no-fehbg
dunst &
sbar &

xset dpms 300 15 # dim 5m, lock 5m15s
xss-lock lock &

exec dbus-launch dwm
