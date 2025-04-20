#!/bin/bash

current_dir=$(pwd)

mkdir -p ~/aur

# install paru
cd ~/aur
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

cd $current_dir

packages=(
  fzf
  zoxide
  network-manager-applet
  networkmanager-openvpn
  flatpak
  git
  neovim
  docker
  docker-compose
  ttf-font-awesome
  noto-fonts-emoji
  ttf-dejavu
  nerd-fonts
  adobe-source-han-sans-otc-fonts
  alacritty
  zellij
  ripgrep
  eza
  bat
  alsa-utils
  lazygit
  git-delta
  discord
  man-db
  man-pages
  fd
)

aur=(
  zen-browser-bin
  pwvucontrol
)

flatpak=(com.saivert.pwvucontrol)

sudo pacman -Syu ${packages[@]}
paru -S $aur
