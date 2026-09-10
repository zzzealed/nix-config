# A shell that bootstraps flake support
let
  settings = import ./settings.nix;
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);
  inherit (lock.nodes.nixpkgs.locked) rev narHash;
  pkgs = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = narHash;
  }) { config = { inherit (settings) allowUnfree; }; };
in
pkgs.mkShell {
  # Enable experimental features without having to specify the argument
  NIX_CONFIG = "experimental-features = ${builtins.concatStringsSep " " settings.experimental-features}";
  packages = with pkgs; [
    nix
    nixos-rebuild-ng
    home-manager
    vim
    git
  ];
}
