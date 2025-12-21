{ pkgs, inputs, stdenv, ... }:
{
  environment.systemPackages = [
    #pkgs.unstable.tidal-hifi
    inputs.tidaluna.packages.${stdenv.hostPlatform.system}.default
  ];
}
