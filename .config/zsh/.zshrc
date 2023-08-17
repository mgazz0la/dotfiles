# mgazz0la .zshrc

if [[ -d $HOME/.oh-my-zsh/ ]]; then
  export ZSH=$HOME/.oh-my-zsh
  export ZSH_CUSTOM=$ZDOTDIR/zcustom

  ZSH_THEME="clean"
  plugins=()
  plugins+=(git)
  plugins+=(zsh-syntax-highlighting)
  plugins+=(zsh-autosuggestions)

  source $ZSH/oh-my-zsh.sh
fi

alias vi=nvim
alias dotctl='/usr/bin/git --git-dir=${HOME}/.dotctl/ --work-tree=${HOME}'

# if exists, source .zshenv.local
[[ -f $ZDOTDIR/.zshrc.local ]] && source $ZDOTDIR/.zshrc.local

# vim: ft=zsh sw=2 ts=2 et
