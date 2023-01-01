#!/bin/sh

#[ "$XDG_VTNR" = 1 ] && exec startx
[ "$XDG_VTNR" = 1 ] && exec sway 2> "$HOME/sway.log"
