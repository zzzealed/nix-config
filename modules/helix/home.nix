{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    package = pkgs.unstable.helix;
    defaultEditor = true;
    extraPackages = import ../lsp/pkgs.nix pkgs;
  };
  home.file.".config/helix" = {
    source = ./config;
    recursive = true;
  };
}
