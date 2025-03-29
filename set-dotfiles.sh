#!/bin/bash

cp ./.gitconfig ~/.gitconfig

cp ./.aliases.sh ~/.aliases.sh
cp ./.zshrc ~/.zshrc

rm -rf ~/.config/nvim
cp -r ./.config/nvim/ ~/.config/nvim

rm -rf ~/.config/lazygit/
cp -r ./.config/lazygit/ ~/.config/lazygit/
