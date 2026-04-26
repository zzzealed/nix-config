{ pkgs, ... }:
{
  programs.ashell = {
    enable = true;
    package = pkgs.unstable.ashell;
    settings = {
      log_level = "warn";
      position = "Bottom";
      appearance = {
        font_name = "CodeNewRoman Nerd Font";
        scale_factor = 1;
        style = "Solid";
      };
      modules = {
        left = [
          "Workspaces"
          "SystemInfo"
        ];
        center = [
          "WindowTitle"
        ];
        right = [
          "Tempo"
        ];
      };
      workspaces = {
        visibility_mode = "MonitorSpecificExclusive";
        group_by_monitor = true;
      };
      system_info = {
        indicators = [ "Memory" ];
        interval = 10;
      };
      window_title = {
        mode = "Title";
        truncate_title_after_length = 50;
      };
      tempo = {
        clock_format = "%a %d %b %R";
        formats = [
          "%Y-%m-%d %H:%M:%S"
        ];
      };
    };
  };
}
