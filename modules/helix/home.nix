{ ... }:
{
  programs.helix.enable = true;
  home.file.".config/helix" = {
    source = ./config;
    recursive = true;
  };
}
