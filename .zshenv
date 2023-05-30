export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CONFIG_DIRS=/etc/xdg
export XDG_DATA_DIRS='/usr/local/share:/usr/share'

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH="$ZDOTDIR/ohmyzsh"
export ZSH_CUSTOM="$ZDOTDIR/custom"
export HISTFILE="$XDG_STATE_HOME/zsh_history"
export ZLE_RPROMPT_INDENT=0
export ZSH_COMPDUMP="$XDG_CACHE_HOME/.zcompdump-$ZSH_VERSION"

export LESSHISTFILE='-'

path=("$HOME/bin" "$HOME/.local/bin" $path)

export EDITOR='nvim'
export MAKEFLAGS='-j'

export XDG_CURRENT_DESKTOP=Unity
export QT_STYLE_OVERRIDE=Materia-dark
