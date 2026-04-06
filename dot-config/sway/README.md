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
- **PDF viewer**: zathura (default via xdg-mime) + sioyek for dissertation work
- **File manager**: Thunar
- **Notifications**: mako (minimal, Wayland-native)
- **Power menu**: fuzzel-based script (lock, logout, reboot, shutdown)
- **Night light**: gammastep (Wayland-native, location-based)
- **Display manager**: GDM for now; lightdm when removing GNOME
- **D-Bus/portals**: environment exported via exec at startup (fixes GTK app slow launch)
- **Help script**: fuzzel-based keybinding viewer ($mod+? to launch)
  - Parses inline `# description` comments from sway config
  - Shows `## Section` headers as separators
  - Resolves sway variables ($mod, $left, etc.) in key names

## Config Conventions

- When adding a new tool/dependency, also add its package to `~/dotfiles/scripts/install-sway.sh`
- **Sway config does not accept inline comments** — `#` comments must be on their own line
- All keybindings live in a single `── Keybindings ──` section at the end of sway/config
- Bindings are grouped under `## Sub-section` headers (Session, Launchers, Windows, Layout, Workspaces, Scratchpad, Media)
- The help script displays `exec` commands using friendly names defined in `friendly_name()` in `sway/scripts/help`
- Use keysym names (e.g. `$mod+question`) over physical key combos for layout independence

## Reference Project

`~/sway-setup` — a third-party sway config cloned for reference. Not used directly,
but individual ideas may be adapted from it.

## Checklist

### Visual/UI
- [x] Notification daemon — mako
- [ ] Wallpaper
- [x] Status bar — swaybar + i3status + wrapper
- [x] Application launcher — fuzzel

### Connectivity
- [ ] WiFi — i3status + nmtui via menu (fuzzel+nmcli quick-connect planned)
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
- [x] Night light — gammastep (location-based)

### Power
- [x] Power menu script — fuzzel-based (lock, logout, reboot, shutdown)
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
- [x] Screenshot tool — grim + slurp + swappy (area and window capture)
- [x] File manager — Thunar
- [x] Text editor — Mousepad in scratchpad ($mod+n)
- [x] PDF viewer — zathura (default) + sioyek for dissertation work
- [ ] Automounting USB (udiskie)
- [ ] environment.d setup for PATH and env vars
- [ ] Update reminders — notify-send via systemd user timer (apt-daily.timer refreshes cache)

### Scripts
- [ ] Dependency install script — single script to apt-install the full sway environment
- [ ] XDG defaults script — set default apps via xdg-settings/xdg-mime (browser, PDF viewer, etc.)

## Existing Files

```
~/dotfiles/dot-config/
├── sway/config       # Main sway config
├── sway/menu         # Fuzzel-based settings launcher
├── i3status/config   # Bar status modules
├── fuzzel/fuzzel.ini # Launcher config
└── foot/foot.ini     # Terminal config
```
