#!/bin/bash

if command -v yay &> /dev/null; then
	echo "Yay is already installed."
else
	echo "Installing yay..."

	# Install dependencies
	sudo pacman -S --needed --noconfirm base-devel git

	# Clone the yay repository
	git clone https://aur.archlinux.org/yay.git
	cd yay

	# Build and install yay
	makepkg -si --noconfirm

	cd ..
	rm -rf yay # Clean up the yay source directory

	echo "yay installation complete."
fi

yay -S --needed --noconfirm zsh

current_login_shell=$(getent passwd "$USER" | awk -F':' '{print $7}')

if [[ "$current_login_shell" != "/bin/zsh" ]]; then
	echo "Changing shell to zsh."
	chsh -s /bin/zsh
else
	echo "Login shell already is zsh."
fi

echo "Creating default folders:"
cd ~
mkdir -vp tmp
mkdir -vp projects
echo "All folders created."

echo "Installing default packages."
yay -S --needed --noconfirm bitwarden discord dropbox eza google-chrome jetbrains-toolbox kitty lazygit localsend-bin neovim obs-studio obsidian ripgrep spotify teamspeak ttf-jetbrains-mono vlc

echo "Installation complete."

echo "Setting configuration files."

exit 0
