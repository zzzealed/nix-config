{ pkgs, ... }:
{
  home.file.".config/mpv" = {
    source = ./config;
    recursive = true;
  };
  programs.mpv = {
    enable = true;
    package = pkgs.unstable.mpv.override {
      scripts = with pkgs.unstable.mpvScripts; [
        webtorrent-mpv-hook
        sponsorblock-minimal
        mpris
        manga-reader
      ];
    };
    includes = [
      "~~/config.conf"
      "~~/profiles.conf"
      "~~/host.conf"
    ];
  };
}
