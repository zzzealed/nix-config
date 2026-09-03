{ lib, inputs, ... }:
let
  cache = import ../../cache.nix;
in
{
  home-manager = {
    backupFileExtension = "bak";
    useGlobalPkgs = true;
    config = {
      home.stateVersion = "24.05";
      imports = [
        ../../modules/git/home.nix
        ../../modules/helix/home.nix
      ];
      programs.helix.extraPackages = [ ];
    };
  };

  # nix-on-droid specifics
  nix = {
    substituters = lib.mkForce cache.substituters;
    trustedPublicKeys = lib.mkForce cache.trusted-public-keys;
    extraOptions = "experimental-features = nix-command flakes";
  };
  environment.etcBackupExtension = ".bak";
  nix.registry.nixpkgs.flake = inputs.nixpkgs-24-05;
  time.timeZone = "Europe/Copenhagen";
  environment.etc."resolv.conf".text = lib.mkForce ''
    nameserver 10.100.0.1
    nameserver 1.1.1.1
    nameserver 1.0.0.1
  '';

  # Read the changelog before changing this value
  system.stateVersion = "24.05";
}
