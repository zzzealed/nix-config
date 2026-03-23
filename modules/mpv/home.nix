{ pkgs, ... }:
{
  home.file.".config/mpv" = {
    source = ./config;
    recursive = true;
  };
  programs.mpv = {
    enable = true;
    package = pkgs.unstable.mpv.override {
      scripts = with pkgs.unstable; [
        mpvScripts.webtorrent-mpv-hook
        mpvScripts.sponsorblock-minimal
        mpvScripts.mpris
      ];
    };
  };
}
