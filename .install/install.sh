#!/bin/bash
set -e

DOTFILE_REPO="https://github.com/mgazz0la/dotfiles"
DOTFILE_BRANCH="archlinux"
DOTCTL_DIR="$HOME/.dotctl"
PACMAN_PKGLIST="pkglist.txt"
PARU_DIR="$HOME/dev/paru"
AUR_PKGLIST="aur_pkglist.txt"

# Exit out if the user is root
if [ "$(id -u)" -eq 0 ]; then
	echo "FATAL: This script should not be run as root. Please run it as a regular user."
	exit 1
fi

# Give a warning if the user is not 'zz'
if [ "$(whoami)" != "zz" ]; then
	read -p "WARNING: some dotfiles expect the user to be 'zz'. Continue? [y/N] " yn
	if [[ ! "$yn" =~ ^[Yy]$ ]]; then
		exit 1
	fi
fi

[ -d "${DOTCTL_DIR}" ] && echo "ERROR: ${DOTCTL_DIR} already exists" && exit 1

# Installing pacman pkgs
sudo pacman -Syq --color=always --noconfirm --needed - <$PACMAN_PKGLIST

# chsh to zsh
if command -v zsh &>/dev/null; then
	# Set zsh as default shell
	if [[ ! "$SHELL" =~ .*zsh.* ]]; then
		echo "=> Setting zsh as default shell"
		chsh -s "$(command -v zsh)"
	fi
else
	echo "WARNING: zsh not found"
fi

# Installing paru
mkdir -p $PARU_DIR
if [ -d "$PARU_DIR/.git" ]; then
	echo "=> Updating paru"
	git -C $PARU_DIR pull --quiet
else
	echo "=> Installing paru"
	git clone --quiet https://aur.archlinux.org/paru.git $PARU_DIR
fi
pushd $PARU_DIR
makepkg -si --noconfirm
popd

# Installing paru pkgs
paru -Syq --color=always --noconfirm --needed - <$AUR_PKGLIST

# Check if git is installed
if ! command -v git &>/dev/null; then
	echo "FATAL: git not found"
	exit 1
fi

# Installing dotfiles
echo "=> Creating $HOME/.dotctl"
mkdir "$HOME/.dotctl"
echo ".dotctl" >>"$HOME/.gitignore"

# Clone bare dotfiles repo
echo "=> Cloning $DOTFILE_REPO"
git clone --quiet --bare "$DOTFILE_REPO" "$HOME/.dotctl"
dotctl="git --git-dir=$HOME/.dotctl/ --work-tree=$HOME"

# Checkout dotfiles, backup conflicting files if necessary
if [[ ! $($dotctl checkout $DOTFILE_BRANCH >/dev/null 2>&1) ]]; then
	echo "=> WARNING: Checkout conflict; backing up conflicting dotfiles and retrying..."
	backup_dir=".config.bak/$(date +"%Y%m%d_%H%M%S")"
	mkdir -p $backup_dir
	$dotctl checkout $DOTFILE_BRANCH 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I{} mv {} $backup_dir/{}
	$dotctl checkout $DOTFILE_BRANCH
	echo "=> All conflicting dotfiles have been backed up to $backup_dir"
fi

# Init submodules
$dotctl config status.showUntrackedFiles no
$dotctl submodule init
$dotctl submodule update

# Done
echo "done! you can reboot now."
