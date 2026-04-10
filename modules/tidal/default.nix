{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.unstable.tidal-hifi ];
}
