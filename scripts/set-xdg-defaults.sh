#!/usr/bin/env bash
# Set default applications via xdg-settings, xdg-mime, and update-alternatives.

set -euo pipefail

msg() { echo -e "\033[0;36m:: $*\033[0m"; }

msg "Setting default browser"
xdg-settings set default-web-browser firefox-esr.desktop

msg "Setting default terminal"
sudo update-alternatives --set x-terminal-emulator /usr/bin/foot

msg "Setting default PDF viewer"
xdg-mime default org.pwmt.zathura.desktop application/pdf

msg "Setting default file manager"
xdg-mime default thunar.desktop inode/directory

msg "Setting default image viewer"
xdg-mime default imv-dir.desktop image/png image/jpeg image/gif image/webp

echo
msg "Done. Verify with:"
echo "  xdg-settings get default-web-browser"
echo "  xdg-mime query default application/pdf"
echo "  xdg-mime query default inode/directory"
