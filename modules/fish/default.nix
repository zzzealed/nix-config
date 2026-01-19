{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    package = pkgs.unstable.fish;
  };
  documentation.man.generateCaches = false;
}
