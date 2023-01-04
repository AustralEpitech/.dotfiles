#!/bin/sh

[ "$XDG_VTNR" = 1 ] && exec startx > "$HOME/gui.log" 2>&1
#[ "$XDG_VTNR" = 1 ] && exec sway 2> "$HOME/sway.log"
