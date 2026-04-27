{ pkgs, ... }:
{
  services.ddclient = {
    enable = true;
    package = pkgs.ddclient;
  };
}
