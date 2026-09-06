{ lib, pkgs, ... }:
{
  programs.btop = {
    enable = true;
    package = lib.mkDefault pkgs.btop.override { cudaSupport = true; };
  };
}
