{ pkgs, ... }:
{
  programs.niri = {
    enable = true;
    package = pkgs.unstable.niri; # TODO: flake
  };
  environment.systemPackages = with pkgs; [
    unstable.xwayland-satellite # X-compatibility
    fuzzel # TODO: Wofi?
    swaynotificationcenter # Notification
    libnotify # swaync dep
    swaylock # Lockscreen, TODO: Get another one
    wpaperd # Wallpaper
    wl-clipboard-rs # Clipboard, I am NOT beating the allegations
  ];
}
