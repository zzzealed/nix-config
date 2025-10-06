# nix-config
My "monorepo" for my [Nix](https://github.com/NixOS/nix) hosts.

# Where is everything?
* `hosts/`:
Host-specific modules and configuration.

* `modules/`:
Shared modules and configuration.

* `overlays/`:
Shared [overlays](https://wiki.nixos.org/wiki/Overlays).

* `secrets/`:
My [agenix](https://github.com/ryantm/agenix) secrets. \
I chose Agenix becuase it seemed the simplest.

# Using
1. Clone, or download the repository:
```sh
curl -L -O https://github.com/zzzealed/nix-config/archive/refs/heads/main.tar.gz
```
2. Unzip with:
```sh
tar -xz main.tar.gz
```
3. Enter shell: 
```sh
cd nix-config-main && nix-shell
```
4. Rebuild with a host's (eg `desktop-nixos`) configuration:
```nix
sudo nixos-rebuild switch --flake .#desktop-nixos
```

> NOTE: You need to use `nixos-generate-config` and replace `hosts/foo/hardware-configuration.nix`.

# To-do
[ ] Init: `services.nginx` (reverse-proxy)
[ ] Init: `services.wireguard` (wireguard-server)
[ ] Fix multi-keyboard layout
[ ] Better `README.md`
[ ] More `pkgs.navi` docs
[ ] SOCKS5 proxy: Init, 3proxy?, proxychains?, networking.proxy?,
[~] Init: `pkgs.glide-browser` (overlay?)
[~] Init: [`services.fabric-servers`](https://github.com/NixOS/nixpkgs/pull/432803)
[?] Auth-middleware, (Authelia?, Authentik?, TinyAuth?, Pocket-ID?, ZITADEL?)
[?] Switch to SOPS-nix
[?] Set up 3rd-party caches (Cachix etc.)
[?] Switch to ZSH
[?] Init: `services.nitter`
