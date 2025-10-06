{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.unstable.legcord ];
}
