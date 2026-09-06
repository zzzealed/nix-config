{ ... }:
{
  imports = [
    ../../modules/users
    ../../modules/users/mads.nix
    ../../modules/networking/firewall.nix
    ../../modules/networking/networkmanager.nix
    ../../modules/networking/nameservers.nix
    ../../modules/bash
    ../../modules/nh
    ../../modules/nix-gc
    ../../modules/nix-index-database
    ../../modules/home-manager
    # Services
    ../../modules/openssh
    ../../modules/wireguard
    ../../modules/wireguard/vps-server.nix
    ../../modules/gatus
    ../../modules/gatus/gatus-public.nix
    ../../modules/nginx
    ../../modules/nginx/rotte.city.nix
    ../../modules/ddclient
    ../../modules/ddclient/vps.nix
    ../../modules/endlessh
    ../../modules/fail2ban
  ];

  home-manager.users.mads.imports = [
    ../../modules/git/home.nix
    ../../modules/btop/home.nix
  ];

  # Workaround for https://github.com/NixOS/nix/issues/8502
  services.logrotate.checkConfig = false;

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  system.stateVersion = "23.11";
}
