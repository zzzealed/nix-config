{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.unstable.swaynotificationcenter # Notification
    pkgs.libnotify # swaync dep, kinda
  ];
}
