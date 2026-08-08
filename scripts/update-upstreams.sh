#!/usr/bin/env bash
set -euo pipefail

root=$(git rev-parse --show-toplevel)
declare -A repos=(
  [waywallen]='waywallen/waywallen'
  [waywallen-display]='waywallen/waywallen-display'
  [open-wallpaper-engine]='waywallen/open-wallpaper-engine'
)

for name in "${!repos[@]}"; do
  tag=$(gh api "repos/${repos[$name]}/releases/latest" --jq .tag_name)
  [[ $tag =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]] || { printf 'Unsupported release tag: %s\n' "$tag" >&2; exit 1; }
  git -C "$root/upstream/$name" fetch --tags origin
  git -C "$root/upstream/$name" checkout --detach "$tag"
done
