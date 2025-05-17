#!/bin/bash

current_dir=$(pwd)

mkdir -p ~/aur

# install paru
#
cd ~/aur
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

cd $current_dir

# pacman

fonts=(
  ttf-jetbrains-mono-nerd
  ttf-dejavu
  noto-fonts-emoji
  noto-fonts-cjk
)

dev=(
  git
  neovim
  docker
  docker-compose
  python-uv
)

utils=(
  fzf
  zoxide
  network-manager-applet
  networkmanager-openvpn
  flatpak
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
  python-watchdog
  xdg-desktop-portal-gtk
  bluez
  bluez-utils
  hyprpolkitagent
)

# aur

aur=(
  zen-browser-bin
  pwvucontrol
)

# flatpak

flatpak=(com.saivert.pwvucontrol com.github.tchx84.Flatseal)

sudo pacman -Syu ${fonts[@]} ${dev[@]} ${utils[@]}
paru -S $aur
flatpak install flathub $flatpak
