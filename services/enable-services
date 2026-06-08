#!/usr/bin/env bash
#
# Enable user systemd timers and services from dotfiles
# Whenever creating new services on dot-config/systemd/user, add them here

set -euo pipefail

systemctl --user daemon-reload
systemctl --user enable --now updates-notify.timer

echo "User services enabled."
