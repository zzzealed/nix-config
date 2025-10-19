{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ( unstable.mpv.override { scripts = [
      mpvScripts.webtorrent-mpv-hook
      mpvScripts.sponsorblock-minimal
      mpvScripts.mpris
    ]; } )
  ];
}
