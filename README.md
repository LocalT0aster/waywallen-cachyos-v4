# Waywallen Arch packages

Source-built generic `x86_64` Arch packages for the Waywallen stack. The
monorepo pins upstream releases as Git submodules and publishes signed packages
to GitHub Pages.

## Packages

- `waywallen`
- `waywallen-display`
- `waywallen-open-wallpaper-engine`

`open-wallpaper-engine` is built after and depends on `waywallen`, which
exports the `waywallen-bridge` CMake package it consumes.

## Install

Import the repository key and configure pacman after GitHub Pages has been
enabled for this repository:

```sh
sudo pacman-key --add keys/waywallen-packages.asc
sudo pacman-key --lsign-key B075783531075AA59D4911C7448DCEC4307C77A0
```

Add this repository to `/etc/pacman.conf`:

```ini
[waywallen]
Server = https://localt0aster.github.io/waywallen-pkgbuilds/x86_64
```

## Local maintenance

```sh
git submodule update --init --recursive
./scripts/update-upstreams.sh
./scripts/update-pkgbuilds.sh
./scripts/build-repository.sh
```

The build script expects a non-root `makepkg` user with permission to install
the just-built dependency packages through `sudo pacman -U`.

## CI signing setup

The signing fingerprint is `B075783531075AA59D4911C7448DCEC4307C77A0`.
Export the private key locally, then add its armored content as the
`PACKAGER_GPG_PRIVATE_KEY` GitHub Actions secret:

```sh
gpg --armor --export-secret-keys B075783531075AA59D4911C7448DCEC4307C77A0
```

Enable GitHub Pages with GitHub Actions as the source before dispatching the
`Publish pacman repository` workflow. The private key is never committed.

CI builds and runs smoke tests on standard GitHub-hosted x86_64 runners.
