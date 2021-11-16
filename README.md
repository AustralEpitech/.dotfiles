# dotfiles

To clone the repo :
```
$ git clone --bare git@github.com:AustralEpitech/.dotfiles.git ~/.dotfiles
$ alias config='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

$ config checkout
# remove conflicted files and re-run the command

$ config submodule update --init --recursive
$ config config status.showUntrackedFiles no
```
