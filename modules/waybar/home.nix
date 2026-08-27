{ pkgs, ... }:
{
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
        modules-left = [
          "niri/workspaces"
          "custom/hostname"
          "memory"
          "custom/wg-server"
          "custom/wg-proton"
        ];
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

        "custom/hostname" = {
          exec = "hostname";
          format = "{}";
          interval = -1;
        };

        "custom/wg-server" = {
          exec = ''
            if systemctl is-active --quiet "wg-quick-wg-server.service"; then
              printf '%s\n' "wg-server: active"
            fi
          '';
          format = "{}";
          interval = 3;
        };

        "custom/wg-proton" = {
          exec = ''
            if systemctl is-active --quiet "wg-quick-wg-proton.service"; then
              printf '%s\n' "wg-proton: active"
            fi
          '';
          format = "{}";
          interval = 3;
        };
      };
    };
  };
}
