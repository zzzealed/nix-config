# nix-config
[![.github/workflows/check-no-build.yml](https://github.com/zzzealed/nix-config/actions/workflows/check-no-build.yml/badge.svg)](https://github.com/zzzealed/nix-config/actions/workflows/check-no-build.yml)
[![.github/workflows/check.yml](https://github.com/zzzealed/nix-config/actions/workflows/check.yml/badge.svg)](https://github.com/zzzealed/nix-config/actions/workflows/check.yml)

My monorepo for my [Nix](https://github.com/NixOS/nix) hosts.

# File structure
* [`hosts/`](./hosts/): Here you'll find any Nix modules that are host-specific and imports for the shared `modules/`-modules.

* [`modules/`](./modules/): Shared Nix modules and configuration that are imported individually per `hosts/foo/configuration.nix`.

* [`overlays/`](./overlays/): Shared [Nix overlays](https://wiki.nixos.org/wiki/Overlays) that are used globally if imported in `overlays/default.nix`.

* [`secrets/`](./secrets/): My [agenix](https://github.com/ryantm/agenix) secrets which are used in various modules, unlocked at rebuild with my host's SSH-keys in `/etc/ssh/`.

* [`flake.nix`](./flake.nix): My [flake](https://wiki.nixos.org/wiki/NixOS_system_configuration#Defining_NixOS_as_a_flake) that essentially acts as blueprint for my hosts. Taking in `inputs` like nixpkgs and passing everything on as the global configuration for my hosts.

# Using
1. Clone, or download the repository:
```sh
curl -L -O https://github.com/zzzealed/nix-config/archive/refs/heads/main.tar.gz
```
2. Unzip with:
```sh
tar -xzf nix-config-main.tar.gz
```
3. Enter shell: 
```sh
cd nix-config-main && nix-shell
```
4. Rebuild and switch with a host's (eg. "desktop-nixos") configuration:
```sh
sudo nixos-rebuild switch --flake .#desktop-nixos
```

> NOTE: You need to use `nixos-generate-config` and replace `hosts/foo/hardware-configuration.nix`.

# To-do
- [ ] Make all files+dirs kebab-case
- [ ] Make custom base16 theme
- [ ] Disable password SSH and add agent
- [ ] Better `README.md`
- [ ] More `pkgs.navi` docs
- [ ] SOCKS5 proxy: Init, 3proxy?, proxychains?, networking.proxy?,
- [ ] `services.*`: Unique ports?
- [ ] Init: Rsync-hbd cron job
- [ ] Add `mpv-playlist-dir-conf` to NUR
- [ ] Auth-middleware, (Authelia?, Authentik?, TinyAuth?, Pocket-ID?, ZITADEL?)
- [ ] Switch to SOPS-nix
- [ ] Set up 3rd-party caches (Cachix etc.)
- [ ] Jujutsu-vcs
- [ ] Switch to Adguard Home
- [x] Ashell bar
- [ ] CrowdSec (+Anubis)
