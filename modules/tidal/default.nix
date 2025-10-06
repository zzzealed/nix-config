{ pkgs, inputs, system, ... }:
{
  environment.systemPackages = [
    pkgs.unstable.tidal-hifi
    #inputs.tidaLuna.packages.${system}.default
  ];
}
