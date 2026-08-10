#!/usr/bin/env bash
set -euo pipefail

status=0
waywallen --help >/dev/null 2>&1 || status=$?
[[ $status -eq 0 || $status -eq 2 ]]

status=0
waywallen-layer-shell --help >/dev/null 2>&1 || status=$?
[[ $status -eq 0 || $status -eq 2 ]]
