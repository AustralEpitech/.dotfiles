if [ "$XDG_VTNR" = 1 ]; then
    GUILOG="$HOME/.local/share/gui.log"

    mkdir -p "$(dirname "$GUILOG")"
    mv "$GUILOG" "$GUILOG.old" 2> /dev/null

    #XDG_CURRENT_DESKTOP=Unity exec startx > "$GUILOG" 2>&1
    SDL_VIDEODRIVER=wayland           \
        _JAVA_AWT_WM_NONREPARENTING=1 \
        QT_QPA_PLATFORM=wayland       \
        XDG_CURRENT_DESKTOP=sway      \
        XDG_SESSION_DESKTOP=sway      \
        MOZ_ENABLE_WAYLAND=1
        exec sway   > "$GUILOG" 2>&1
fi

# vim: ft=zsh
