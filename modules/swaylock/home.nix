{ pkgs, lib, ... }:
let
  wallpapers = import ../stylix/wallpapers.nix pkgs;
in
{
  programs.swaylock.enable = true;
  stylix = {
    targets.swaylock = {
      image = {
        enable = true;
        override = lib.mkForce "${wallpapers.phaethon}";
      };
    };
  };
}
