{ ... }:
{
  # Nix modules
  imports = [
    ../../secrets/default.nix
    ../../modules/users/mads.nix
    ../../modules/cli-tools
    ../../modules/git
    ../../modules/home-manager
    ../../modules/helix
    ../../modules/bash
    ../../modules/stylix
    #../../modules/systemd-boot
    ../../modules/networkmanager
    ../../modules/openssh
    ../../modules/nh
    # Services
    ../../modules/wireguard
  ];

  # Boot
  boot.loader = {
    grub.enable = false;
    generic-extlinux-compatible.enable = true;
  };

  # Networking
  networking.hostId = "cf20a29f";
  #networking.interfaces.enp3s0.wakeOnLan.enable = true; # TODO

  # State
  system.stateVersion = "24.05";
}
