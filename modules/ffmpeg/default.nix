{ pkgs, ... }:
{
  environment.systemPackages = [ ((pkgs.ffmpeg-full.override { withUnfree = true; }).overrideAttrs (_: { doCheck = false; })) ]; # https://wiki.nixos.org/wiki/FFmpeg#Speeding_up_install
}

