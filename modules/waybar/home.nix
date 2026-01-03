{ ... }:
{
  programs.waybar = {
    enable = true;
#    style = ''
#    window#waybar {
#      margin-top: 5px;
#      margin-left: 5px;
#      margin-right: 5px;
#    }
#    '';
  };

  home.file.".config/waybar/config.jsonc" = {
    source = ./config/config.jsonc;
  };
  home.file.".config/waybar/wg-quick.sh" = {
    source = ./config/wg-quick.sh;
    executable = true;
  };
}
