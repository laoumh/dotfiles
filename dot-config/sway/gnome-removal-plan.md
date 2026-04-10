# GNOME Removal Plan

## Prerequisites
- [x] nwg-hello + greetd installed and working (vt=7)
- [ ] Polkit agent ready (add `exec lxpolkit` to sway config when needed)
- [ ] Keyring — WiFi passwords in /etc/NetworkManager/system-connections/, gnome-keyring likely not needed

## Phase 1 — GNOME apps and games (safe, sway unaffected)

```
sudo apt remove gnome-games aisleriot gnome-2048 gnome-chess gnome-klotski \
  gnome-mahjongg gnome-mines gnome-nibbles gnome-robots gnome-sudoku \
  gnome-taquin gnome-tetravex four-in-a-row iagno nautilus gnome-terminal \
  gnome-text-editor gnome-calculator gnome-calendar gnome-characters \
  gnome-clocks gnome-contacts gnome-connections gnome-disk-utility \
  gnome-font-viewer gnome-logs gnome-maps gnome-music gnome-sound-recorder \
  gnome-snapshot gnome-system-monitor gnome-weather gnome-software \
  gnome-color-manager gnome-backgrounds gnome-video-effects gnome-tour \
  gnome-user-docs gnome-user-share gnome-remote-desktop gnome-sushi \
  gnome-browser-connector gnome-tweaks gnome-initial-setup loupe totem \
  seahorse baobab file-roller rhythmbox yelp gtranslator rygel \
  evolution-ews-core guake drawing gedit
sudo apt autoremove
```

## Phase 2 — GNOME shell and GDM (after this, GNOME won't launch)

```
sudo apt remove gnome gnome-core gnome-shell gdm3 gnome-session \
  gnome-settings-daemon gnome-control-center gnome-online-accounts \
  gnome-menus gnome-shell-pomodoro tecla xdg-desktop-portal-gnome
sudo apt autoremove
```

## Phase 3 — Cleanup stragglers

Review what's left and remove in small batches:
- ibus (if no non-Latin input needed): ibus ibus-data ibus-gtk ibus-gtk3 ibus-gtk4 im-config
- CUPS (if no printing): cups cups-browsed cups-client cups-daemon cups-filters cups-pk-helper
- Accessibility (if not needed): orca speech-dispatcher speech-dispatcher-espeak-ng espeak-ng-data
- Tracker/TinySPARQL: tinysparql tracker-extract
- PackageKit: packagekit packagekit-tools

After each phase: `dpkg -l | grep gnome | grep ^ii | wc -l` to check what's left.

## Keep list
- adwaita-icon-theme, gnome-icon-theme, gnome-themes-extra (GTK theming)
- gnome-desktop3-data, glycin-loaders
- gnome-bluetooth-3-common, libgnome-bluetooth-3.0-13 (py3status bluetooth)
- network-manager-openvpn-gnome
- xdg-desktop-portal-gtk (needed for sway portals)
- pinentry-gnome3 (GPG prompts)
- libxml2 and related libs
