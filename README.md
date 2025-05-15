# Dotfiles' Josafa

Welcome to my Dotfiles. I use:

- arch linux;
- hyprland;
- waybar;
- wofi;
- kitty/alacritty/wezterm;
- tmux/zellij;
- nvim.

## Notes

Some notes about my config.

### Fonts

Fonts to must have
- [Dejavu](https://archlinux.org/packages/extra/any/ttf-dejavu/), for braille support
- [Noto fonts emoji](https://archlinux.org/packages/extra/any/noto-fonts-emoji/)
- [Noto fonts CJK](https://archlinux.org/packages/extra/any/noto-fonts-cjk/)
- [Jetbrains nerd font](https://archlinux.org/packages/extra/any/ttf-jetbrains-mono-nerd/)

### Hyprpaper

I use `python-watchdog` to change my wallpaper in live. Just put
/scripts/watch-wallpaper in ~/.scripts to hot reload wallpaper on change
wallpaper in path ~/Pictures/wallpapers/current/active.

See commands above to enable this feat

```sh
# sudo pacman -S python-watchdog
mkdir -p ~/.scripts
cp ./scripts/watch-wallpaper in ~/.scripts
cp .config/systemd/user/watch-wallpaper.service ~/.config/systemd/user/watch-wallpaper.service
systemctl --user enable --now watch-wallpaper.service
```

### Hyprcursor

I use [catppuccin cursors](https://github.com/catppuccin/cursors). Make sure that
it is installed:

```sh
paru -S catppuccin-cursors-mocha
```

> [!warning]
> xcursor fallback may  not work properly, so force it.
> either, flatpak gtk apps may not work. see instructions below


```sh
dconf write /org/gnome/desktop/interface/cursor-theme "'catppuccin-mocha-blue-cursors'"

# xcursor
xrdb -merge <<< "Xcursor.theme: catppuccin-mocha-blue-cursors"

# flatpak
flatpak override --user --filesystem=~/.config/dconf:ro

# or
flatpak run --command=sh app
dconf write /org/gnome/desktop/interface/cursor-theme "'catppuccin-mocha-blue-cursors'"
```

### Third-Party

Some important apps are not in base_packages.sh. They are:

- [asdf](https://asdf-vm.com/);
