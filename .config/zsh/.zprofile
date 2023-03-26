#!/bin/sh

[ "$XDG_VTNR" = 1 ] && exec startx > "$HOME/.gui.log" 2>&1
#[ "$XDG_VTNR" = 1 ] && export XDG_CURRENT_DESKTOP=sway && exec sway > "$HOME/.gui.log" 2>&1
