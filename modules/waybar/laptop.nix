{ ... }:
{
  programs.waybar.settings.mainBar = {
    modules-left = [ "battery" ];
    battery = {
      format = "{capacity}% PWR ({time})";
      tooltip-format = "{timeTo}";
      states = {
        "critical" = 25;
      };
      events = {
        "on-discharging-critical" = "notify-send -u critical 'Low battery!'";
        # Not released yet:
        # "on-discharging" = "notify-send -u critical 'Discharging'";
        # "on-charging" = "notify-send -u critical 'Charging'";
      };
    };
  };
}
