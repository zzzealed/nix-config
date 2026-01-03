{ pkgs, ... }:
{
  imports = [ ./mnt-hbd.nix ];
  environment.systemPackages = [ pkgs.rclone ];
}
