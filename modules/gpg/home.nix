{ pkgs, ... }:
{
  programs.gpg = {
    enable = true;
    package = pkgs.gnupg;
  };
  services.gpg-agent = {
    enable = true;
    enableScDaemon = true;
    pinentry = {
      package = pkgs.pinentry-curses;
      program = "pinentry-curses";
    };
  };
}
