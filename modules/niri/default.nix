{ pkgs, ... }:
{
  programs.niri = {
    enable = true;
    package = pkgs.unstable.niri; # TODO: flake
  };
  environment.systemPackages = with pkgs; [
    unstable.xwayland-satellite # X-compatibility
    unstable.walker # App launcher
    swaynotificationcenter # Notification
    swaylock # Lockscreen, TODO: Get another one
    unstable.swww # Wallpaper
    wl-clipboard-rs # Clipboard, I am NOT beating the allegations
  ];
}
