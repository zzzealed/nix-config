{ pkgs, ... }:
{
  programs.niri = {
    enable = true;
    package = pkgs.unstable.niri; # TODO: flake
  };
  environment.systemPackages = with pkgs; [
    unstable.xwayland-satellite # X-compatibility
    #walker # App launcher
    fuzzel
    swaynotificationcenter # Notification
    swaylock # Lockscreen, TODO: Get another one
    unstable.swww # Wallpaper
    wl-clipboard-rs # Clipboard, I am NOT beating the allegations
  ];
}
