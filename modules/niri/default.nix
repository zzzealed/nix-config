{ pkgs, ... }:
{
  programs.niri = {
    enable = true;
    package = pkgs.unstable.niri; # TODO: flake
  };
  environment.systemPackages = with pkgs; [
    unstable.xwayland-satellite # X-compatibility
    wl-clipboard-rs # Clipboard, I am NOT beating the allegations
    libnotify
    wlsunset
  ];
}
