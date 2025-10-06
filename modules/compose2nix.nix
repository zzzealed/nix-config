{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.compose2nix ];
}
