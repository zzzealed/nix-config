{ pkgs, ... }:
{
  programs.btop.package = pkgs.btop.override { cudaSupport = true; };
}
