#!/bin/bash

dconf load /org/gnome/desktop/wm/keybindings/ < gnome_keybindings.ini

cp ./.gitconfig ~/.gitconfig

cp ./.aliases.sh ~/.aliases.sh
cp ./.zshrc ~/.zshrc
cp ./zshenv ~/.zshenv

rm -rf ~/.config/nvim
cp -r ./.config/nvim/ ~/.config/nvim

rm -rf ~/.config/lazygit/
cp -r ./.config/lazygit/ ~/.config/lazygit/

rm -rf ~/scripts
cp -r ./scripts ~/scripts

cp ./.config/systemd/user/*.service ~/.config/systemd/user/
systemctl --user enable --now `/bin/ls .config/systemd/user/*.service | xargs -n 1 basename`
