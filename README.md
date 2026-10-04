# eggrror404's dotfiles

dotfiles are managed by GNU Stow. apply with the following

```sh
stow .
```

## notes

- Noctalia templates

  i'm using Noctalia to generate color-synced themes for GTK 3/4, QT, Hyprland (built-in), fcitx5, vicinae (copied from community).

  to properly apply them:
  - GTK3: use the `adw-gtk3` theme
  - GTK4: use the default Adwaita theme
  - QT: select the `noctalia` color palette in `qt5ct` and `qt6ct`
  - fcitx5: no settings required, but the follow system light/dark color scheme option should be off.

- GTK

  to remove the close button in gtk:

  ```sh
  gsettings set org.gnome.desktop.wm.preferences button-layout "appmenu:"
  ```

- fontconfig

  relative symlinks stow creates do not get along with flatpak, so i made stow ignore the fontconfig directory.
  absolute symlinks or a full copy may be manually done.

- Zen

  Zen by default has a floating title bar when hovered, which would become empty after removing the close button. turn it off in `about:config` with option `zen.view.experimental-no-window-controls`.
