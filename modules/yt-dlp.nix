{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.unstable.yt-dlp
  ];
}
