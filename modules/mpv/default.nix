{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.unstable.mpv ];
}
