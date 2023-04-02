#!/bin/sh

GUILOG="$HOME/.local/share/xorg/gui.log"

mv "$GUILOG" "$GUILOG.old" 2> /dev/null

[ "$XDG_VTNR" = 1 ] && exec startx > "$GUILOG" 2>&1
#[ "$XDG_VTNR" = 1 ] && export XDG_CURRENT_DESKTOP=sway && exec sway > "$HOME/.gui.log" 2>&1
