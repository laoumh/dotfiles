# Sway Setup Plan

## Goal

Build a custom Sway environment from scratch, favoring Debian-packaged tools,
minimal dependencies, and full understanding of every config line. No third-party
repos or remote script piping.

## Decisions Made

- **Bar**: swaybar + i3status + wrapper script (JSON i3bar protocol)
  - i3status handles: wifi, ethernet, VPN, battery, memory, time
  - Wrapper script injects: bluetooth status, better separators
  - Non-interactive bar; all actions via keybindings or fuzzel menus
- **Launcher**: fuzzel (already configured)
- **Terminal**: foot (already configured, catppuccin-mocha, JetBrainsMono Nerd Font)
- **Lock**: swaylock + swayidle (already configured: lock at 5min, dpms off at 10min, lock before sleep)
- **Settings menu**: fuzzel-based `menu` script for wifi, bluetooth, audio, display, theme
- **Keyboard**: Brazilian layout (xkb_layout br)
- **Text editor**: Mousepad (spell check, dark mode, scratchpad notepad via $mod+n)
- **File manager**: Thunar
- **D-Bus/portals**: environment exported via exec at startup (fixes GTK app slow launch)

## Checklist

### Visual/UI
- [ ] Notification daemon (mako or dunst — pick one)
- [ ] Wallpaper
- [x] Status bar — swaybar + i3status + wrapper
- [x] Application launcher — fuzzel

### Connectivity
- [x] WiFi — i3status + nm-connection-editor via menu
- [ ] Bluetooth — wrapper script for bar status, blueman for management
- [x] VPN — i3status path_exists

### System Integration
- [x] Screen locking — swaylock + swayidle
- [ ] Polkit agent (lxpolkit or polkit-gnome)
- [ ] Keyring/secrets (gnome-keyring or keepassxc)
- [x] XDG portals — xdg-desktop-portal-wlr + gtk, env exported to systemd/D-Bus
- [ ] Clipboard manager (wl-clipboard + cliphist)

### Media/Hardware
- [x] Volume control — pactl via media keys
- [x] Brightness control — brightnessctl via media keys
- [ ] Media keys (playerctl)
- [ ] Display management — wdisplays in menu, kanshi for auto-profiles (optional)

### Power
- [ ] Power menu script (shutdown/reboot/logout via fuzzel)
- [x] Battery indicator — i3status
- [x] Idle/suspend — swayidle
- [ ] Lid close behavior

### Theming/Appearance
- [ ] GTK theme (gtk-3.0/settings.ini)
- [ ] Qt theme (qt5ct)
- [ ] Cursor theme
- [x] Font — JetBrainsMono Nerd Font (pango font set in sway config for bar icons)
- [ ] Icon theme
- [ ] Color scheme — currently neutral grays, decide on final palette

### Misc
- [ ] Screenshot tool — expand beyond full-screen (add area + clipboard with grim + slurp)
- [x] File manager — Thunar
- [x] Text editor — Mousepad in scratchpad ($mod+n)
- [ ] Automounting USB (udiskie)
- [ ] environment.d setup for PATH and env vars

## Existing Files

```
~/dotfiles/dot-config/
├── sway/config       # Main sway config
├── sway/menu         # Fuzzel-based settings launcher
├── i3status/config   # Bar status modules
├── fuzzel/fuzzel.ini # Launcher config
└── foot/foot.ini     # Terminal config
```
