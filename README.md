# eggrror404's dotfiles

dotfiles are managed by GNU Stow. apply with the following

```sh
stow .
```

## notes

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
