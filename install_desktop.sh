#!/bin/bash

create_default_folders() {
  echo "Creating default folders:"
  cd ~ || echo "Could not navigate to home directory; folders not created." && return
  mkdir -vp tmp
  mkdir -vp projects
  echo "All folders created."
}

install_yay() {
  if command -v yay &>/dev/null; then
    echo "Yay is already installed."
  else
    echo "Installing yay..."
    # Install dependencies
    sudo pacman -S --needed --noconfirm base-devel git

    # Clone the yay repository
    git clone https://aur.archlinux.org/yay.git
    {
      cd yay || echo "yay was not downloaded correctly." && exit 1
      # Build and install yay
      makepkg -si --noconfirm
    }

    # Clean up the yay source directory
    rm -rf yay
    echo "yay installation complete."
  fi
}

change_login_shell() {
  current_login_shell=$(getent passwd "$USER" | awk -F':' '{print $7}')
  if [[ "$current_login_shell" != "/bin/zsh" ]]; then
    echo "Changing shell to zsh."
    chsh -s /bin/zsh
  else
    echo "Login shell already is zsh."
  fi
}

# ===== begin installation =====
install_yay

# install zsh (if needed)
yay -S --needed --noconfirm zsh

change_login_shell
create_default_folders

echo "Installing default packages."
yay -S --needed --noconfirm bitwarden discord dropbox eza google-chrome jetbrains-toolbox kitty lazygit localsend-bin neovim obs-studio obsidian ripgrep spotify teamspeak ttf-jetbrains-mono vlc
echo "Installation complete."

echo "Setting configuration files."

exit 0
