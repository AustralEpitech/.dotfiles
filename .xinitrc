#!/bin/sh

# keyboard
numlockx

# display
xrandr \
    --output HDMI1 --auto --primary
feh --bg-tile "$XDG_CONFIG_HOME/wallpapers/landscape.png" --no-fehbg

# startup
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1      & # arch
#/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 & # debian
#/usr/libexec/polkit-gnome-authentication-agent-1               & # fedora
picom                                                          &
redshift                                                       &
dunst                                                          &
sbar                                                           &

xset dpms 300 # lock 5m
xss-lock -- lock &

exec dbus-launch dwm
