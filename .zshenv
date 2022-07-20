export PYENV_ROOT="$HOME/.pyenv"

path=(~/bin ~/.local/bin $PYENV_ROOT/bin $path)

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"

export ZDOTDIR="$HOME"/.config/zsh
export HISTFILE="$XDG_STATE_HOME"/zsh/history

export MOZ_ENABLE_WAYLAND=1

export EDITOR="nvim"
