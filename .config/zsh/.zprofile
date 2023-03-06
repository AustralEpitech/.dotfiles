#!/bin/sh

[ "$XDG_VTNR" = 1 ] && select SESSION in startx sway; do
    [ "$SESSION" = sway ] && export XDG_CURRENT_DESKTOP=sway
    exec $SESSION > "$HOME/.gui.log" 2>&1
done
