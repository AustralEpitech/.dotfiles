if [ "$XDG_VTNR" = 1 ]; then
    GUILOG="$HOME/.local/share/xorg/gui.log"

    mv "$GUILOG" "$GUILOG.old" 2> /dev/null
    exec startx > "$GUILOG" 2>&1
    #export XDG_CURRENT_DESKTOP=sway && exec sway > "$HOME/.gui.log" 2>&1
fi

# vim: ft=zsh
