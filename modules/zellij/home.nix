{ ... }:
{
  home.file.".config/zellij" = {
    source = ./config;
    recursive = true;
  };
}
