{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.unstable.streamlink
  ];
}
