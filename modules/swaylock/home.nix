{ pkgs, lib, ... }:
let
  wallpapers = import ../stylix/wallpapers.nix pkgs;
in
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock;
  };
  stylix = {
    targets.swaylock = {
      image = {
        enable = true;
        override = lib.mkForce "${wallpapers.phaethon}";
      };
    };
  };
}
