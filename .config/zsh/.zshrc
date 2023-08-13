# mgazz0la .zshrc
pfetch
fortune -se starwars sports question-answer-jokes matrix \
  | cowsay -f small -W 80 \
  | lolcat -b -r

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

# vim: ft=zsh sw=2 ts=2 et
