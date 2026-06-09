{ ... }:
{
  # Nix modules
  imports = [
    ../../modules/users
    ../../modules/users/groups.nix
    ../../modules/users/mads.nix
    ../../modules/cli-tools
    ../../modules/git
    ../../modules/home-manager
    ../../modules/bash
    ../../modules/networking/firewall.nix
    ../../modules/networking/networkmanager.nix
    ../../modules/networking/nameservers.nix
    ../../modules/openssh
    ../../modules/nh
    ../../modules/zfs
    ../../modules/nix-gc
    ../../modules/nix-index-database
    # Services
    ../../modules/wireguard
    ../../modules/wireguard/server.nix
    ../../modules/samba-shares
    ../../modules/samba-shares/vault2-share.nix
  ];

  home-manager.users.mads = {
    imports = [
      ../../modules/git/home.nix
      ../../modules/helix/home.nix
      ../../modules/navi/home.nix
      ../../modules/btop/home.nix
    ];
  };

  # Boot
  boot.loader = {
    grub.enable = false;
    generic-extlinux-compatible.enable = true;
  };

  # State
  system.stateVersion = "24.05";
}
