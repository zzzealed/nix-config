{ ... }:
{
  imports = [ ./bibata-cursors.nix ];
  xdg.icons = {
    enable = true;
    fallbackCursorThemes = [ "Bibata-Modern-Ice" ];
  };
}
