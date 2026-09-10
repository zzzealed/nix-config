{ pkgs, ... }:
let
  gparted = pkgs.writeShellApplication {
    name = "gparted";
    text = ''
      exec sudo -E ${pkgs.gparted-full}/bin/gparted "$@"
    '';
  };
in
{
  environment.systemPackages = [ gparted ];
}
