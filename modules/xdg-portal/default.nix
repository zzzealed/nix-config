{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
    # Explicitly tell it which portal handles which interface
    config.common.default = "kde";
  };
}
