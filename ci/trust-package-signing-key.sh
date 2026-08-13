#!/usr/bin/env bash
set -euo pipefail

key_file="${1:-keys/waywallen-packages.asc}"
fingerprint=B075783531075AA59D4911C7448DCEC4307C77A0

pacman-key --init
pacman-key --add "$key_file"
pacman-key --lsign-key "$fingerprint"
