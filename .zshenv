# canonical .zshenv

# sets $ZDOTDIR and sources the real .zshenv over there.
export ZDOTDIR=$HOME/.config/zsh
[[ -f $ZDOTDIR/.zshenv ]] && . $ZDOTDIR/.zshenv

# vim: ft=zsh sw=2 ts=2 et
