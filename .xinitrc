#!/bin/sh

# bar
#(i3status | while read line; do xsetroot -name "$line"; done) &

# startup
set-display                                          &
xss-lock -n screensaver -- lock                      &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1          || # arch
    /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 || # debian
    /usr/libexec/polkit-gnome-authentication-agent-1 &                # fedora
picom                                                &
gammastep 2> /dev/null                               &
sbar                                                 &

exec dbus-launch dwm
