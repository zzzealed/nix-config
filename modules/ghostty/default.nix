{ inputs, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.unstable.ghostty
    #inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
