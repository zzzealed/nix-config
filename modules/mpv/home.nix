{ ... }:
{
  programs.mpv.enable = true;
  home.file.".config/mpv" = {
    source = ./config;
    recursive = true;
  };
}
