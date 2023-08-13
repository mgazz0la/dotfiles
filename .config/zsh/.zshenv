# mgazz0la .zshenv

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export ZSH_CACHE_DIR=$XDG_CACHE_HOME/zsh
export HISTFILE=$ZSH_CACHE_DIR/.zhistory

if command -v nvim &> /dev/null; then
  EDITOR=nvim
elif command -v vim &> /dev/null; then
  EDITOR=vim
elif command -v vi &> /dev/null; then
  EDITOR=vi
else
  EDITOR=nano
fi
export EDITOR
export VISUAL=$EDITOR

if command -v nvim &> /dev/null; then
  MANPAGER='nvim +Man!'
else
  MANPAGER='less -FirSwX'
fi
export MANPAGER
export PAGER='less -FirSwX'

export GPG_TTY=$(tty)

export PATH=$PATH:$HOME/bin

# if exists, source .zshenv.local
[[ -f $ZDOTDIR/.zshenv.local ]] && source $ZDOTDIR/.zshenv.local

# vim: ft=zsh sw=2 ts=2 et
