#!/usr/bin/env bash
# Install dependencies for the sway environment defined in ~/dotfiles.
# Debian-only. No third-party repos or remote script piping.

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

msg()  { echo -e "${CYAN}:: $*${NC}"; }
ok()   { echo -e "${GREEN}:: $*${NC}"; }
die()  { echo -e "${RED}:: ERROR: $*${NC}" >&2; exit 1; }


### Package lists ###

# Core compositor + session
CORE=(
    sway swayidle swaylock swaybg
    xdg-desktop-portal-wlr xdg-desktop-portal-gtk
)

# Bar + status
BAR=(
    py3status
    # swaybar ships with sway
)

# Terminal, launcher, notifications
SHELL_UI=(
    foot foot-themes fuzzel mako-notifier
)

# Apps referenced in config / README
APPS=(
    mousepad          # scratchpad notepad
    thunar            # file manager
    zathura           # PDF viewer
    pavucontrol       # audio mixer (menu script)
    # Wi-Fi: nmtui/nmcli ship with network-manager, no extra package needed
)

# CLI tools used in keybindings / scripts
TOOLS=(
    gawk              # help script parser
    grim              # screenshot
    slurp             # area selection for screenshot
    swappy            # screenshot editor
    brightnessctl     # brightness keys
    pulseaudio-utils  # pactl for volume keys
    playerctl         # media keys (README planned)
    wl-clipboard      # clipboard (README planned)
    gammastep         # night light
    jq                # general utility / bar wrapper
)

# GUI utilities from menu script
MENU_UTILS=(
    blueman           # bluetooth manager
    wdisplays         # display/monitor settings
    nwg-look          # GTK theme settings
)

# Fonts
FONTS=(
    # JetBrainsMono Nerd Font installed via install-font.sh
    fonts-noto-color-emoji
    fonts-inter           # swaylock font
)

# Theming
THEMING=(
    numix-gtk-theme
    numix-icon-theme
)


### Install ###

ALL_PACKAGES=(
    "${CORE[@]}"
    "${BAR[@]}"
    "${SHELL_UI[@]}"
    "${APPS[@]}"
    "${TOOLS[@]}"
    "${MENU_UTILS[@]}"
    "${FONTS[@]}"
    "${THEMING[@]}"
)

# Filter out comments and empty entries
INSTALL=()
for pkg in "${ALL_PACKAGES[@]}"; do
    [[ "$pkg" =~ ^# ]] && continue
    INSTALL+=("$pkg")
done

msg "The following packages will be installed:"
echo "  ${INSTALL[*]}" | fold -s -w 72 | sed 's/^/  /'
echo

read -p "Proceed? [y/N] " -n 1 -r
echo
[[ $REPLY =~ ^[Yy]$ ]] || exit 0

msg "Updating package lists..."
sudo apt update

msg "Installing packages..."
sudo apt install "${INSTALL[@]}"

ok "Done. Log out and select Sway from your display manager, or run 'sway' from a TTY."
msg "Run 'nwg-look' to configure GTK theme, icons, and fonts."
