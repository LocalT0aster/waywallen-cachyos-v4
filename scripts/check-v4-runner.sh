#!/usr/bin/env bash
set -euo pipefail

if /lib/ld-linux-x86-64.so.2 --help 2>/dev/null | grep -Fq 'x86-64-v4 (supported'; then
  echo 'v4_supported=true' >> "${GITHUB_OUTPUT:-/dev/null}"
  echo 'Runner supports x86-64-v4; package tests may execute.'
else
  echo 'v4_supported=false' >> "${GITHUB_OUTPUT:-/dev/null}"
  echo 'Runner does not support x86-64-v4; executable package tests are skipped.'
fi
