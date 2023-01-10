ZSH_THEME="powerlevel10k/powerlevel10k"
CASE_SENSITIVE="true"
zstyle ':omz:update' mode disabled

plugins=(vi-mode colored-man-pages git gitignore)

. "$ZSH"/oh-my-zsh.sh

mkdir -p "$XDG_CACHE_HOME/zsh"
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

. "$ZDOTDIR"/.docker_aliases
. "$ZDOTDIR"/.kubectl_aliases
. "$ZDOTDIR"/.zsh_aliases

! [ -f "$ZDOTDIR/.p10k.zsh" ] || . "$ZDOTDIR/.p10k.zsh"
