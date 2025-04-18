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
  flatpak
  git
  ttf-dejavu
  nerd-fonts
  alacritty
  zellij
  ripgrep
  eza
  bat
  alsa-utils
  lazygit
  git-delta
)

aur=(
  ttf-joypixels
  zen-browser-bin
)

flatpak=(com.saivert.pwvucontrol)

sudo pacman -Syu $packages
paru -S $aur
flatpak install flathub $flatpak
