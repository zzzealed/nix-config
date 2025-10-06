{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.bibata-cursors ];
  xdg.icons = {
    enable = true;
    fallbackCursorThemes = [ "Bibata-Modern-Ice" ];
  };
}
