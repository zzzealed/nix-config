{ pkgs, ... }:
{
  # Unstable
  # programs.libreoffice = {
  # enable = true;
  # package = pkgs.unstable.libreoffice;
  # };
  home.packages = [ pkgs.unstable.libreoffice ];
}
