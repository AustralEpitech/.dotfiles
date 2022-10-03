export PYENV_ROOT="$HOME/.pyenv"
export VIRTUAL_ENV="$PYENV_ROOT"

path=(~/bin ~/.local/bin "$VIRTUAL_ENV"/bin $path)

export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state
export XDG_CONFIG_DIRS=/etc/xdg
export XDG_DATA_DIRS='/usr/local/share/:/usr/share/'

export ZDOTDIR="$HOME"/.config/zsh
export HISTFILE="$XDG_STATE_HOME"/zsh/history

export LESSHISTFILE='-'

export MOZ_ENABLE_WAYLAND=1
# fix Java Windows
export _JAVA_AWT_WM_NONREPARENTING=1

export EDITOR='nvim'
