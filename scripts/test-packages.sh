#!/usr/bin/env bash
set -euo pipefail

waywallen_output=$(waywallen --help 2>&1 || true)
[[ $waywallen_output == *'usage: waywallen '* ]]

layer_shell_output=$(waywallen-layer-shell --help 2>&1 || true)
[[ $layer_shell_output == *'usage: waywallen-layer-shell '* ]]
