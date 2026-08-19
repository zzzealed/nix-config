{ pkgs, ... }:
{
  boot.loader.limine.secureBoot.enable = true;
  environment.systemPackages = [ pkgs.sbctl ];
}
