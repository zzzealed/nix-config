{ pkgs, ... }:
{
  programs.niri = {
    enable = true;
    package = pkgs.unstable.niri; # TODO: flake
  };
  environment.systemPackages = with pkgs; [
    unstable.xwayland-satellite # X-compatibility
    unstable.fuzzel # TODO: Wofi?
    swaynotificationcenter # Notification
    swaylock # Lockscreen, TODO: Get another one
    wpaperd # Wallpaper
    wl-clipboard-rs # Clipboard, I am NOT beating the allegations
  ];
}
