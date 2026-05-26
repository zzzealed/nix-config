{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.unstable.teamspeak6-client ];
}
