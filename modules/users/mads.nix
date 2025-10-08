{ config, ... }:
{
  age.secrets.mads-password.file = ../../secrets/mads-password.age;
  users.users.mads = {
    description = "Mads";
    home = "/home/mads";
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "adbusers" "gamemode" ];
    hashedPasswordFile = config.age.secrets.mads-password.path;
    linger = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL0bskvLTrkiFLQeS4K1uc8EwNGXrCcigrRZa/dPcycI mads@desktop-nixos"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOo+0J8abiPou6UWCuolKS0RriZ5zAYrgV2zdgIYTuQ5 mads@server-nixos"
    ];
  };
  nix.settings.trusted-users = [ "mads" ]; # Needed for remote rebuilds

  # Home manager
  home-manager.users.mads = {
    xdg.enable = true;
    imports = [
      ../fish/home.nix
      ../mpv/home.nix
      ../firefox/home.nix
      #../steam/home.nix TODO: Fix
      ../ghostty/home.nix
      ../git/home.nix
      ../helix/home.nix
      ../navi/home.nix
      ../niri/home.nix
    ];
  };
}
