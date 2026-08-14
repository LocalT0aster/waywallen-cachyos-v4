#!/usr/bin/env bash
set -euo pipefail

root=$(git rev-parse --show-toplevel)
output=${1:-"$root/dist/x86_64"}
mkdir -p "$output"
install -Dm644 "$root/site/index.html" "$(dirname "$output")/index.html"

for package in waywallen waywallen-display open-wallpaper-engine; do
  (
    cd "$root/packages/$package"
    makepkg_args=(--syncdeps --noconfirm --cleanbuild)
    if [[ ${SIGN_PACKAGES:-1} == 1 ]]; then
      makepkg_args+=(--sign)
    fi
    makepkg "${makepkg_args[@]}"
    package_files=()
    while IFS= read -r package_file; do
      [[ $package_file == *-debug-*.pkg.tar.zst ]] && continue
      package_files+=("$package_file")
    done < <(makepkg --packagelist)
    ((${#package_files[@]})) || { printf 'No installable package was produced.\n' >&2; exit 1; }

    install -Dm644 "${package_files[@]}" "$output/"
    if [[ ${SIGN_PACKAGES:-1} == 1 ]]; then
      for package_file in "${package_files[@]}"; do
        install -Dm644 "${package_file}.sig" "$output/"
      done
    fi
    if command -v sudo >/dev/null; then
      sudo pacman -U --noconfirm "${package_files[@]}"
    else
      pacman -U --noconfirm "${package_files[@]}"
    fi
  )
done

if [[ ${SIGN_PACKAGES:-1} == 1 ]]; then
  repo-add --sign "$output/waywallen.db.tar.zst" "$output"/*.pkg.tar.zst
else
  repo-add "$output/waywallen.db.tar.zst" "$output"/*.pkg.tar.zst
fi
