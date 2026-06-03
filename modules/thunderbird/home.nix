{ pkgs, ... }:
{
  programs.thunderbird = {
    enable = true;
    package = pkgs.thunderbird;
    # TODO: profiles
    # TODO: settings
  };
}
