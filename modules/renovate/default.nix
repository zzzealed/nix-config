{ pkgs, ... }:
{
  services.renovate = {
    enable = true;
    package = pkgs.renovate;
    runtimePackages = [ ];
    credentials = ;
    settings =;
  };
}
