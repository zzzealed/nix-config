{ pkgs, ... }:
{
  imports = [ ./hbd.nix ];
  environment.systemPackages = [ pkgs.rclone ];
}
