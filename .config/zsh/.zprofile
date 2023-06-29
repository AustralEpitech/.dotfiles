if [ "$XDG_VTNR" = 1 ]; then
    GUILOG="$HOME/.local/share/gui.log"

    mkdir -p "$(dirname "$GUILOG")"
    mv "$GUILOG" "$GUILOG.old" 2> /dev/null

    #export XDG_CURRENT_DESKTOP=Unity && exec startx > "$GUILOG" 2>&1
    export XDG_CURRENT_DESKTOP=sway  && exec sway   > "$GUILOG" 2>&1
fi

# vim: ft=zsh
