{ ... }:
{
  programs.waybar.settings.mainBar = {
    modules-left = [ "memory" ];
    memory = {
      format = "{percentage}% RAM";
    };
  };
}
