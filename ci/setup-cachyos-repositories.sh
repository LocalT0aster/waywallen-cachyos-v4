#!/usr/bin/env bash
set -euo pipefail

pacman -Syu --noconfirm --needed archlinux-keyring curl
pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
pacman-key --lsign-key F3B607488DB35A47
pacman -U --noconfirm \
  'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-20240331-1-any.pkg.tar.zst' \
  'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-27-1-any.pkg.tar.zst' \
  'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v4-mirrorlist-27-1-any.pkg.tar.zst'
cat >> /etc/pacman.conf <<'EOF'

[cachyos-v4]
Include = /etc/pacman.d/cachyos-v4-mirrorlist
[cachyos-core-v4]
Include = /etc/pacman.d/cachyos-v4-mirrorlist
[cachyos-extra-v4]
Include = /etc/pacman.d/cachyos-v4-mirrorlist
EOF
pacman -Sy --noconfirm
