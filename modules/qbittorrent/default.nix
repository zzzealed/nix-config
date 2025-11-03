{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.unstable.qbittorrent ];
}
