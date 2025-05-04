#!/bin/bash

watchmedo shell-command "$HOME/Pictures/wallpapers/current" \
    --wait \
    --patterns='active' \
    --recursive \
    --command='pkill hyprpaper; hyprctl dispatch exec hyprpaper'
