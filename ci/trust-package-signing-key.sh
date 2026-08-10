#!/usr/bin/env bash
set -euo pipefail

key_file="${1:-keys/waywallen-cachyos-v4.asc}"
fingerprint=9EB061F8BA4ACE8D2AF6AC70CB133F037BD453CA

pacman-key --add "$key_file"
pacman-key --lsign-key "$fingerprint"
