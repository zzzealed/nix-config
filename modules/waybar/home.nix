{ ... }:
{
  programs.waybar = {
    enable = true;
  };

  home.file.".config/waybar/config.jsonc" = {
    source = ./config/config.jsonc;
  };
  home.file.".config/waybar/wg-quick.sh" = {
    source = ./config/wg-quick.sh;
    executable = true;
  };
}
