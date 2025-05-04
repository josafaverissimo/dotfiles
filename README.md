# dotfiles

Fonts to must have
- [Dejavu](https://archlinux.org/packages/extra/any/ttf-dejavu/) (braile support)
- [NotoFontsEmoji](https://archlinux.org/packages/extra/any/noto-fonts-emoji/) (Emojis)
- [Adobe](https://archlinux.org/packages/extra/any/adobe-source-han-sans-otc-fonts/) (Chinese/Japan/Korean)

Programs to must have
- Alacritty
- neovim
- zellij
- bat
- ripgrep
- eza

## Notes

### Hyprpaper

run `pacman -S python-watchdog` and put /scripts/watch-wallpaper in ~/.scripts/bin
to hot reload wallpaper on change wallpaper in path ~/Pictures/wallpapers/current/active.

copy /.config/systemd/user/watch-wallpaper.service to ~/.config/systemd/user/watch-wallpaper.service
and run systemd --user --enable now watch-wallpaper.service.

### Xcursor
To force xcursor theme

```sh
xrdb -merge <<< "Xcursor.theme: catppuccin-mocha-blue-cursors"
```

#### Flatpaks

Some gtk apps creates its own config, to get your custom cursor, set:

```sh
flatpak override --user --filesystem=~/.config/dconf:ro
```
