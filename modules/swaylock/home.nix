{ pkgs, lib, ... }:
let
  wallpapers = import ../stylix/wallpapers.nix pkgs;
in
{
  programs.swaylock.enable = true;

  services.swayidle = {
    enable = true;
    events.lock = "${pkgs.swaylock}/bin/swaylock -efFkl";
  };

  stylix = {
    targets.swaylock = {
      image = {
        enable = true;
        override = lib.mkForce "${wallpapers.nix-snowflake}";
      };
    };
  };
}
