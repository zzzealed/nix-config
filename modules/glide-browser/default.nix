{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (callPackage ./derivation.nix {})
  ];
}
