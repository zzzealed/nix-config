{ ... }:
{
  programs.waybar.settings.mainBar = {
    modules-left = [ "battery" ];
    battery = {
      format = "{capacity}% PWR";
      tooltip-format = "{timeTo}";
    };
  };
}
