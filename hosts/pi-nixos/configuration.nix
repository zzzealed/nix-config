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
    ../../modules/networkmanager
    ../../modules/networkmanager/server-dns.nix
    ../../modules/openssh
    ../../modules/nh
    ../../modules/zfs
    # Services
    ../../modules/wireguard
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

  system.switch.enable = true;

  # Boot
  boot.loader = {
    grub.enable = false;
    generic-extlinux-compatible.enable = true;
  };

  # Networking
  networking.hostId = "cf20a29f";

  # State
  system.stateVersion = "24.05";
}
