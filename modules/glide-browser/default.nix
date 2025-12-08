{ pkgs, ... }:
#let
#  glide-browser = pkgs.callPackage ./package.nix {};
#in
{
#  environment.systemPackages = [ pkgs.ff2mpv ];
#  programs.firefox = {
#    enable = true;
#    package = glide-browser;
#    languagePacks = [ "en-US" "da" ];
#    nativeMessagingHosts.packages = [ pkgs.ff2mpv ]; # This doesn't actually work. 
#  };
#  environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1"; # https://wiki.nixos.org/wiki/Firefox#Wayland_support

  environment.systemPackages = with pkgs; [
    (callPackage ./package.nix {})
  ];

}
