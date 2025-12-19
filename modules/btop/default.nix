{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.btop-cuda ];
}
