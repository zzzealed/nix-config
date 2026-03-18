{ pkgs, inputs, ... }:
{
  environment.systemPackages = [
    pkgs.unstable.tidal-hifi
    #inputs.tidaluna.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
