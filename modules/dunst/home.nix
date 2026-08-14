{ pkgs, ... }:
{
  # TODO: bind `dunstctl close`
  services.dunst = {
    enable = true;
    package = pkgs.dunst;
    settings = {
      global.follow = "mouse"; # Show at focused window
    };
  };
}
