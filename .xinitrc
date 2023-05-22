#!/bin/sh

# display
## laptop
if ls -d /sys/class/power_supply/BAT*/ > /dev/null 2>&1; then
    stimeout=300
else # desktop
    stimeout=1800
fi

cycle=15                         # lock 15 sec after stimeout
dpms="$((stimeout + cycle + 1))" # turn off screen 1 sec after lock

xset s "$stimeout" "$cycle"                                                 &
xset dpms "$dpms" "$dpms" "$dpms"                                           &
feh --bg-fill "$XDG_CONFIG_HOME/wallpapers/mount_cook.jpg" --no-fehbg       &
xss-lock -n "feh --fullscreen $XDG_CONFIG_HOME/wallpapers/lock.png" -- lock &

# bar
#(i3status | while read line; do xsetroot -name "$line"; done) &

# startup
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1          || # arch
    /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 || # debian
    /usr/libexec/polkit-gnome-authentication-agent-1    &             # fedora
picom                                                   &
gammastep 2> /dev/null                                  &
sbar                                                    &

exec dbus-launch dwm
