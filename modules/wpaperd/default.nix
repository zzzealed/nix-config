{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.wpaperd
  ];
}
