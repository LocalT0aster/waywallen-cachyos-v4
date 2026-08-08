# Waywallen CachyOS v4 packages

Source-built, `x86-64-v4`-optimized Arch packages for the Waywallen stack.
The monorepo pins upstream releases as Git submodules and publishes signed
`x86_64` packages to GitHub Pages.

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
sudo pacman-key --add keys/waywallen-cachyos-v4.asc
sudo pacman-key --lsign-key 9EB061F8BA4ACE8D2AF6AC70CB133F037BD453CA
```

Add this repository above CachyOS repositories in `/etc/pacman.conf`:

```ini
[waywallen-cachyos-v4]
Server = https://localt0aster.github.io/waywallen-cachyos-v4/x86_64
```

The packages require an `x86-64-v4` CPU. Confirm support before installing:

```sh
/lib/ld-linux-x86-64.so.2 --help | grep 'x86-64-v4 (supported'
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

The signing fingerprint is `9EB061F8BA4ACE8D2AF6AC70CB133F037BD453CA`.
Export the private key locally, then add its armored content as the
`PACKAGER_GPG_PRIVATE_KEY` GitHub Actions secret:

```sh
gpg --armor --export-secret-keys 9EB061F8BA4ACE8D2AF6AC70CB133F037BD453CA
```

Enable GitHub Pages with GitHub Actions as the source before dispatching the
`Publish pacman repository` workflow. The private key is never committed.

## Runner safety

CI always compiles `x86-64-v4` packages. It checks the dynamic loader's CPU
capability report before executing a built binary and skips executable tests on
runners that do not advertise v4 support.
