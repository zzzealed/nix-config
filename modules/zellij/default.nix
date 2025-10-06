{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.unstable.zellij ];
}
