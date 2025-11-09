{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.navi pkgs.jq ];
}
