{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ( unstable.mpv.override { scripts = [
      mpvScripts.webtorrent-mpv-hook
      mpvScripts.sponsorblock-minimal
      mpvScripts.mpris
#      (mpvScripts.thumbnail.overrideAttrs (oldAttrs: {
#        src = pkgs.fetchFromGitHub {
#          owner = "Alistair1231";
#          repo = "mpv_thumbnail_script";
#          rev = "v0.5.4+1";
#          sha256 = "sha256-0JXnR3oWkPKTC+Io+Rkb77WU/qyoGbue1bIa2fzEvWE=";
#        };
#      }))
    ]; } )
  ];
}
