{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    package = pkgs.unstable.yazi;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
}
