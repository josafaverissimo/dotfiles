#!/bin/bash

dconf dump /org/gnome/desktop/wm/keybindings/ > gnome_keybindings.ini

cp ~/.gitconfig ./
cp ~/.aliases.sh ./
cp ~/.zshrc ./
cp ~/.zshenv ./
cp -r ~/.config/nvim ./.config/
cp -r ~/.config/lazygit/ ./.config
cp ~/.config/systemd/user/*.service ./.config/systemd/user
cp -r ~/scripts ./scripts/
