{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.unstable.zmx
    pkgs.rust-petname # See Fish config
  ];
}
