# mgazz0la .zshrc

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="clean" # set by `omz`
export ZSH_CUSTOM=$ZDOTDIR/zcustom
plugins=()
plugins+=(git)
plugins+=(zsh-syntax-highlighting)
plugins+=(zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

alias vi=nvim
alias dotctl='/usr/bin/git --git-dir=${HOME}/.dotctl/ --work-tree=${HOME}'

# if exists, source .zshenv.local
[[ -f $ZDOTDIR/.zshrc.local ]] && source $ZDOTDIR/.zshrc.local

# vim: ft=zsh sw=2 ts=2 et
