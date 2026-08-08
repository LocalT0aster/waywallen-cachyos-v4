#!/usr/bin/env bash
set -euo pipefail

root=$(git rev-parse --show-toplevel)
output=${1:-"$root/dist/x86_64"}
mkdir -p "$output"

for package in waywallen waywallen-display open-wallpaper-engine; do
  (
    cd "$root/packages/$package"
    makepkg_args=(--syncdeps --noconfirm --cleanbuild)
    if [[ ${SIGN_PACKAGES:-1} == 1 ]]; then
      makepkg_args+=(--sign)
    fi
    makepkg "${makepkg_args[@]}"
    install -Dm644 ./*.pkg.tar.zst "$output/"
    if [[ ${SIGN_PACKAGES:-1} == 1 ]]; then
      install -Dm644 ./*.pkg.tar.zst.sig "$output/"
    fi
    package_file=$(printf '%s\n' ./*.pkg.tar.zst)
    if command -v sudo >/dev/null; then
      sudo pacman -U --noconfirm "$package_file"
    else
      pacman -U --noconfirm "$package_file"
    fi
  )
done

if [[ ${SIGN_PACKAGES:-1} == 1 ]]; then
  repo-add --sign "$output/waywallen-cachyos-v4.db.tar.zst" "$output"/*.pkg.tar.zst
else
  repo-add "$output/waywallen-cachyos-v4.db.tar.zst" "$output"/*.pkg.tar.zst
fi
