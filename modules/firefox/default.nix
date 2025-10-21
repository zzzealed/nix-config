{ pkgs, ... }:
{
  # My preferences are set in config/user.js
  programs.firefox = {
    enable = true;
    #package = pkgs.unstable.glide-browser; # TODO: can I do this?
    languagePacks = [ "en-US" "da" ];
    # TODO: Actually switch to another fucking browser (Servo come save me)
    nativeMessagingHosts.packages = [
      pkgs.ff2mpv
    ];
  };
  environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1"; # https://wiki.nixos.org/wiki/Firefox#Wayland_support
}
