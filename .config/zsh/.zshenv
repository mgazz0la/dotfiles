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
export HISTSIZE=5000
export SAVEHIST=500000
setopt appendhistory
setopt sharehistory
setopt incappendhistory



editors=(nvim vim vi nano)
for ed in $editors; do
  [[ $(command -v $ed) ]] && export EDITOR=$ed && break
done
export VISUAL=$EDITOR

[[ $(command -v nvim) ]]            \
  && export MANPAGER='nvim +Man!'   \
  || export MANPAGER='less -FirSwX'

export PAGER='less -FirSwX'

export GPG_TTY=$(tty)

[[ $(command -v go) ]] && \
  export PATH=$PATH:$(go env GOPATH)/bin

# if exists, source .zshenv.local
[[ -f $ZDOTDIR/.zshenv.local ]] && source $ZDOTDIR/.zshenv.local

# vim: ft=zsh sw=2 ts=2 et
