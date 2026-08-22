{ pkgs, ... }:
{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    limine = {
      enable = true;
      package = pkgs.limine;
    };
  };
}
