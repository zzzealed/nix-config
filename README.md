# nix-config
[![.github/workflows/check-no-build.yml](https://github.com/zzzealed/nix-config/actions/workflows/check-no-build.yml/badge.svg)](https://github.com/zzzealed/nix-config/actions/workflows/check-no-build.yml)
[![.github/workflows/build.yml](https://github.com/zzzealed/nix-config/actions/workflows/build.yml/badge.svg)](https://github.com/zzzealed/nix-config/actions/workflows/build.yml)


## File structure
* [`modules/`](./modules/): Shared Nix modules and configuration that are imported individually per `hosts/foo/configuration.nix`.

* [`overlays/`](./overlays/): Shared [Nix overlays](https://wiki.nixos.org/wiki/Overlays) that are used globally if imported in `overlays/default.nix`.

* [`secrets/`](./secrets/): My [agenix](https://github.com/ryantm/agenix) secrets which are used in various modules, unlocked at rebuild with my host's SSH-keys in `/etc/ssh/`.

* [`templates/`](./templates/): Template files for various configs.

* [`flake.nix`](./flake.nix): My [Nix flake](https://wiki.nixos.org/wiki/NixOS_system_configuration#Defining_NixOS_as_a_flake) that essentially acts as blueprint for my hosts. Taking in `inputs` like nixpkgs and passing everything on as the global configuration for my hosts.

* [`nix.nix`](./nix.nix): Various Nix package-manager and settings.

* [`shell.nix`](./shell.nix): A [Nix shell](https://wiki.nixos.org/wiki/Development_environment_with_nix-shell) to bootstrap flake-support.

## Using
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

## To-do
- [ ] Make all files+dirs kebab-case
- [ ] Make custom base16 theme
- [ ] Disable password SSH and add agent
- [ ] Better `README.md`
- [ ] More `pkgs.navi` docs
- [ ] SOCKS5 proxy: Init, 3proxy?, proxychains?, networking.proxy?,
- [ ] `services.*`: Unique ports?
- [ ] Init: Rsync-hbd cron job
- [ ] Auth-middleware, (Authelia?, Authentik?, TinyAuth?, Pocket-ID?, ZITADEL?)
- [ ] Switch to SOPS-nix
- [ ] Jujutsu-vcs
- [ ] Just rawdog dnsmasq instead of Pihole
- [ ] CrowdSec (+Anubis?)
