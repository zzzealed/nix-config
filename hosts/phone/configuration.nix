{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  cache = import ../../cache.nix;
in
{
  environment.packages =
    (import ../../modules/cli-tools { inherit pkgs; }).packages
    ++ (with pkgs; [
      gnutar
      man
      inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
      iputils
    ]);
  home-manager = {
    backupFileExtension = "bak";
    useGlobalPkgs = true;
    config = {
      home.stateVersion = "24.05";
      imports = [
        ../../modules/bash/home.nix
        ../../modules/vim/home.nix
        ../../modules/git/home.nix
        ../../modules/openssh/home.nix
        ../../modules/helix/home.nix
        ../../modules/btop/home.nix
      ];
      programs.helix.extraPackages = [ ];
    };
  };

  # nix-on-droid specifics
  nix = {
    extraOptions = "experimental-features = nix-command flakes";
    substituters = lib.mkForce cache.substituters;
    trustedPublicKeys = lib.mkForce cache.trusted-public-keys;
  };
  environment.etcBackupExtension = ".bak";
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  time.timeZone = "Europe/Copenhagen";
  environment.etc."resolv.conf".text = lib.mkForce ''
    nameserver 10.100.0.1
    nameserver 1.1.1.1
    nameserver 1.0.0.1
  '';

  # Read the changelog before changing this value
  system.stateVersion = "24.05";
}
