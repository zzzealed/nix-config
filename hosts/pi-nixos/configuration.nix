{ ... }:
{
  # Nix modules
  imports = [
    ../../secrets/default.nix
    ../../modules/users/mads.nix
    ../../modules/cli-tools
    ../../modules/git
    ../../modules/home-manager
    ../../modules/bash
    ../../modules/networkmanager
    ../../modules/openssh
    ../../modules/nh
    # Services
    ../../modules/wireguard
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
  #networking.interfaces.enp3s0.wakeOnLan.enable = true; # TODO

  # State
  system.stateVersion = "24.05";
}
