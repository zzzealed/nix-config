{ pkgs, ... }:
{
  programs.adb = {
    enable = true;
  };
  environment.systemPackages = [
    pkgs.android-tools
    pkgs.scrcpy
  ];
}
