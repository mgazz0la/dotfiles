# mgazzola | .zshenv
# .zshenv is always sourced

# Path to oh-my-zsh installation [[possibly OS specific!]]
export ZSH="/home/mgazzola/.oh-my-zsh"
export EDITOR="/usr/bin/nvim"

# Standard $PATH
export PATH=/home/mgazzola/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
# Add golang and rust binaries to $PATH
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/mgazzola/.cargo/bin

export GPG_TTY=$(tty)
