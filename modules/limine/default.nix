{ pkgs, ... }:
{
  boot.loader.limine = {
    enable = true;
    package = pkgs.limine;
  };
}
