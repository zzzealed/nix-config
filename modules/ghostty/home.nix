{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    package = pkgs.unstable.ghostty;
    enableBashIntegration = true;
    enableFishIntegration = true;
    installBatSyntax = true;
  };
  home.file.".config/ghostty" = {
    source = ./config;
    recursive = true;
  };
}
