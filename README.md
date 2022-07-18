# dotfiles

To clone the repo :
```console
# pacman -Syu --needed zsh sway firefox alacritty neovim

$ git clone --bare git@github.com:AustralEpitech/.dotfiles.git ~/.dotfiles
$ alias config='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

$ config checkout
# remove conflicted files and re-run the command

$ config submodule update --init --recursive --remote
$ config config status.showUntrackedFiles no
```

To update submodules:
```
$ config submodule update --recursive --remote
```
