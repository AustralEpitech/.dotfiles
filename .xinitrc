#!/bin/sh

# keyboard
numlockx

# display
xrandr                                           \
    --output eDP-1           --auto  --primary   \
    --output DisplayPort-1-1 --auto --pos 1920x0 \
    --output DisplayPort-1-2 --auto --pos 3840x0
feh --bg-fill "$XDG_CONFIG_HOME/wallpapers/monerochan.png" --no-fehbg

# startup
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1       & # arch
#/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 & # debian
#/usr/libexec/polkit-gnome-authentication-agent-1               & # fedora
picom                                                           &
redshift                                                        &
dunst                                                           &
sbar                                                            &

xss-lock -- lock &
if ls -d /sys/class/power_supply/BAT*/ > /dev/null 2>&1; then
    xset dpms 300 300 300 # Turn of the screen after 5 min
    xset s    315         # Lock Screen after 15 secs later
else
    xset dpms 1800 1800 1800 # Turn of the screen after 30 min
    xset s    1815           # Lock Screen 15 sec later
fi

exec dbus-launch dwm
