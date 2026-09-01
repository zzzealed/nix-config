{ inputs, pkgs, ... }:
{
  home.file = {
    ".config/mpv" = {
      source = ./config;
      recursive = true;
    };
    ".config/mpv/scripts/autosave.lua".source = "${inputs.autosave-lua}/autosave.lua";
  };

  programs.mpv = {
    enable = true;
    package = pkgs.unstable.mpv.override {
      scripts = with pkgs; [
        unstable.mpvScripts.webtorrent-mpv-hook
        unstable.mpvScripts.sponsorblock-minimal
        unstable.mpvScripts.mpris
        unstable.mpvScripts.manga-reader
        nur.repos.zeal.playlist-dir-conf
      ];
    };
    includes = [
      "~~/config.conf"
      "~~/profiles.conf"
      "~~/host.conf"
    ];
  };
}
