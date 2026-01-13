{ pkgs, inputs, system, ... }:
{
  # TODO: ${stdenv.hostPlatform.system}
  environment.systemPackages = [
    pkgs.unstable.tidal-hifi
    #inputs.tidaluna.packages.${system}.default
  ];
}
