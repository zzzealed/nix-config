{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.unstable.yt-dlp
    pkgs.deno # Deno needed now: https://github.com/yt-dlp/yt-dlp/issues/14404
  ];
}
