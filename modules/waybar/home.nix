{ pkgs, ... }:
{
  home.file.".config/waybar/wg-quick.sh" = {
    source = ./config/wg-quick.sh;
    executable = true;
  };
  programs.waybar = {
    enable = true;
    package = pkgs.unstable.waybar;
    # Remove allat UGLY styling of workspaces
    style = ''
      #workspaces button {
        all: unset;
        padding: 0 4px;
      } 
    '';
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        spacing = 15;
        margin-top = 0;
        margin-right = 0;
        margin-left = 0;
        margin-bottom = 0;
        modules-left = [ "niri/workspaces" "memory" "custom/wg-quick" ];
        modules-center = [ "niri/window" ];
        modules-right = [ "clock" ];
    
        "niri/window" = {
          format = "{title}";
          icon = true;
          icon-size = 15;
        };
    
        "niri/workspaces" = {
          format = "{index}";
          disable-click = true;
          current-only = true;
        };
    
        memory = {
          format = "{percentage}% RAM";
        };
    
        clock = {
          interval = 1;
          format = "{:%d/%m/%Y %T}";
          tooltip-format = "{:%A, %B %e. %G at %r %Z}";
        };
    
        "custom/wg-quick" = {
          exec = "~/.config/waybar/wg-quick.sh";
          format = "{}";
          interval = 3;
        };
      };
    };
  };
}
