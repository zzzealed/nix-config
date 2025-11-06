{ pkgs, inputs, system, ... }:
{
  environment.systemPackages = [
    #pkgs.unstable.tidal-hifi
    inputs.tidaluna.packages.${system}.default
  ];
}
