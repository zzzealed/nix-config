{ pkgs, lib, ... }:
let
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/8g/wallhaven-8g5w52.png";
    hash = "sha256-z9KVl3hYQmmyGkPU8lnM5mTBbEiPbhysUb6oEVO7reA=";
  };
in
{
  programs.swaylock.enable = true;
  stylix = {
    targets.swaylock = {
      image = {
        enable = true;
        override = lib.mkForce "${wallpaper}";
      };
    };
  };
}
