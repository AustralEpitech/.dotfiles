ZSH_THEME="powerlevel10k/powerlevel10k"
CASE_SENSITIVE="true"
zstyle ':omz:update' mode disabled

plugins=(vi-mode colored-man-pages git gitignore)

# doesn't work in .zshenv
fpath=("$ZDOTDIR/completions" $fpath)
. "$ZSH"/oh-my-zsh.sh

. "$ZDOTDIR"/.docker_aliases
. "$ZDOTDIR"/.kubectl_aliases
. "$ZDOTDIR"/.zsh_aliases

. "$ZDOTDIR/.p10k.zsh"

# vim: ft=zsh
