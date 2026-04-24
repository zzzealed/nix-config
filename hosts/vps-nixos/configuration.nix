{ ... }: {
  imports = [
    ../../modules/users
    ../../modules/users/mads.nix
    ../../modules/networkmanager
    ../../modules/networkmanager/server-dns.nix
    ../../modules/bash
    ../../modules/nh
    # Services
    ../../modules/openssh
    ../../modules/wg-quick
    ../../modules/wg-quick/wg_pi-nixos-4.nix
    ../../modules/gatus
    ../../modules/nginx
    ../../modules/nginx/rotte.city.nix
    ../../modules/ddclient
    ../../modules/ddclient/vps.rotte.city.nix
    ../../modules/ntfy-sh
  ];

  # Workaround for https://github.com/NixOS/nix/issues/8502
  services.logrotate.checkConfig = false;

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  #networking.hostName = "instance-20260423-1921";
  networking.domain = "";
  system.stateVersion = "23.11";

}
