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

HISTSIZE=5000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=5000               #Number of history entries to save to disk
#HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed

# if exists, source .zshenv.local
[[ -f $ZDOTDIR/.zshrc.local ]] && source $ZDOTDIR/.zshrc.local

# vim: ft=zsh sw=2 ts=2 et
