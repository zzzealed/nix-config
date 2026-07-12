{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.unstable.zmx ];
}
