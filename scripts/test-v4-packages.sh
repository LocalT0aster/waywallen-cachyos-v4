#!/usr/bin/env bash
set -euo pipefail

if ! /lib/ld-linux-x86-64.so.2 --help 2>/dev/null | grep -Fq 'x86-64-v4 (supported'; then
  echo 'Skipping executable tests: runner lacks x86-64-v4 support.'
  exit 0
fi

status=0
waywallen --help >/dev/null 2>&1 || status=$?
[[ $status -eq 0 || $status -eq 2 ]]

status=0
waywallen-layer-shell --help >/dev/null 2>&1 || status=$?
[[ $status -eq 0 || $status -eq 2 ]]
