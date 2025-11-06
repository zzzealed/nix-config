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
    # Services
    ../../modules/pihole
    ../../modules/unbound
    # TODO: wireguard
  ];

  # Boot
  boot.loader.grub.enable = true;

  # Networking
  networking.hostId = "cf20a29f";
  #networking.interfaces.enp3s0.wakeOnLan.enable = true; # TODO

  # State
  system.stateVersion = "24.05";
  home-manager.users.mads.stateVersion = "24.05";
}
