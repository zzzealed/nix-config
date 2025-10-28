{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (callPackage ./package.nix {})
  ];
}
