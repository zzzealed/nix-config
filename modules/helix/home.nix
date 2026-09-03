{ lib, pkgs, ... }:
{
  programs.helix = {
    enable = true;
    package = pkgs.helix;
    defaultEditor = true;
    extraPackages = lib.mkDefault (import ../lsp/pkgs.nix pkgs);
  };
  home.file.".config/helix" = {
    source = ./config;
    recursive = true;
  };
}
