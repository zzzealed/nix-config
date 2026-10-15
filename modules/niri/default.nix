{ inputs, pkgs, ... }:
{
  programs.niri = {
    enable = true;
    package = pkgs.unstable.niri;
  };
  environment.systemPackages = with pkgs; [
    inputs.xwayland-satellite.packages.${pkgs.stdenv.hostPlatform.system}.default # X-compatibility
    # xwayland-satellite
    wl-clipboard-rs # Clipboard, I am NOT beating the allegations
    libnotify
    wlsunset
  ];
}
