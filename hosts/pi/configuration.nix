{ ... }:
{
  # Nix modules
  imports = [
    ../../modules/users
    ../../modules/users/groups.nix
    ../../modules/users/mads.nix
    ../../modules/users/nixremote.nix
    ../../modules/cli-tools
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
    ../../modules/bluetooth
    # Services
    ../../modules/samba-shares
    ../../modules/samba-shares/vault2-share.nix
    ../../modules/ddclient
    ../../modules/ddclient/pi.nix
    ../../modules/wireguard
    ../../modules/wireguard/pi-server.nix
    ../../modules/home-assistant
    ../../modules/earlyoom
  ];

  home-manager.users.mads.imports = [
    ../../modules/git/home.nix
    ../../modules/btop/home.nix
  ];

  # Swap
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8192;
    }
  ];
  zramSwap.enable = true;

  # Boot
  boot.loader = {
    grub.enable = false;
    generic-extlinux-compatible.enable = true;
  };

  # State
  system.stateVersion = "24.05";
}
