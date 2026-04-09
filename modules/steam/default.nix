{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    extest.enable = true;
    package = pkgs.unstable.steam;
    protontricks = {
      enable = true;
      package = pkgs.unstable.protontricks;
    };
    extraCompatPackages = [
      pkgs.unstable.proton-ge-bin
    ];
    extraPackages = [
      pkgs.unstable.gamescope
    ];
  };
}
