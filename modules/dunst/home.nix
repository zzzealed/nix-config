{ pkgs, ... }:
{
  # TODO: bind `dunstctl close`
  services.dunst = {
    enable = true;
    package = pkgs.dunst;
    iconTheme.name = "Papirus";
    iconTheme.package = pkgs.papirus-icon-theme;
    settings = {
      global.follow = "mouse"; # Show at focused window
    };
  };
}
