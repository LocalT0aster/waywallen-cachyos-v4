#!/usr/bin/env bash
set -euo pipefail

id -u builder >/dev/null 2>&1 || useradd --create-home builder
install -d -o builder -g builder /home/builder/.cargo /home/builder/.cache
printf 'builder ALL=(ALL) NOPASSWD: ALL\n' > /etc/sudoers.d/builder
chmod 440 /etc/sudoers.d/builder
chown -R builder:builder "$GITHUB_WORKSPACE"
