#!/usr/bin/env bash
set -euo pipefail

root=$(git rev-parse --show-toplevel)
declare -A package_dirs=(
  [waywallen]='waywallen'
  [waywallen-display]='waywallen-display'
  [open-wallpaper-engine]='open-wallpaper-engine'
)

for source_name in "${!package_dirs[@]}"; do
  version=$(git -C "$root/upstream/$source_name" describe --tags --exact-match | sed 's/^v//')
  pkgbuild="$root/packages/${package_dirs[$source_name]}/PKGBUILD"
  sed -i -E "s/^pkgver=.*/pkgver=${version}/" "$pkgbuild"
  (
    cd "$(dirname "$pkgbuild")"
    updpkgsums
    makepkg --printsrcinfo > .SRCINFO
  )
done
