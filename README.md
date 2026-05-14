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
- [ ] Init: `services.authelia`
- [ ] Init: `services.octodns` blocker: nixos/nixpkgs#517510
- [ ] Init: `services.crowdsec` blocker: nixos/nixpkgs#446307
- [ ] Init: `pkgs.zmx` blocker: nixos/nixpkgs#468608
- [ ] Init: `sops.secrets` blocker: mic92/sops-nix#779, mic92/sops-nix#922
- [ ] Make all files+dirs kebab-case
- [ ] Make custom base16 theme
- [ ] Disable password SSH and add agent
- [ ] More `pkgs.navi` docs
- [ ] `services.*`: Unique ports?
- [ ] Just rawdog dnsmasq instead of Pihole
