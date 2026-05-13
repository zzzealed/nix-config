# AGENTS.md

## Setup commands
- Enter shell: `nix-shell`
- Run tests: `nix flake check --no-build`

## General information
- Please read `README.md` as it contains more information.
- Nginx reverse-proxy in `modules/nginx` and various `modules/<some_service>/default.nix`.
- Domains `https://*.l.zzzealed.com` is used for local services, and defined in `modules/pihole/default.nix`.
- Secrets in `secrets/` and uses [agenix](https://github.com/ryantm/agenix).

## Dev environment tips
- Look up config as needed, most often in `modules/`.
- Suggest `, <some_package>` to run packages that aren't installed.
- Use `man 5 configuration.nix` to see all NixOS options.
- Use `man 5 home-configuration.nix` to see all Home Manager options.
- Suggest `sudo systemctl restart --user <some_homemanager_service>` to restart Home Manager services.
