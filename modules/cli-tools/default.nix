{ pkgs, ... }:
{
  packages = with pkgs; [
    fastfetch
    gomi
    ripgrep
    tree
    uutils-coreutils
  ];
}
