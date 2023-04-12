#!/bin/sh

# keyboard
numlockx &

# display
xrandr \
    --output eDP --auto  --primary &
feh --bg-fill "$XDG_CONFIG_HOME/wallpapers/monerochan.png" --no-fehbg &
xss-lock -n "feh --fullscreen $XDG_CONFIG_HOME/wallpapers/lock.png" -- lock &
(
    # desktop
    stimeout=1800
    # laptop
    ls -d /sys/class/power_supply/BAT*/ > /dev/null 2>&1 && stimeout=300

    cycle=15                         # lock 15 sec after stimeout
    dpms="$((stimeout + cycle + 1))" # turn off screen 1 sec after lock

    xset s "$stimeout" "$cycle"
    xset dpms "$dpms" "$dpms" "$dpms"
) &

# startup
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1       & # arch
#/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 & # debian
#/usr/libexec/polkit-gnome-authentication-agent-1               & # fedora
picom                                                           &
gammastep 2> /dev/null                                          &
dunst                                                           &
sbar                                                            &

exec dbus-launch dwm
