{ inputs, pkgs, ... }:
{
  imports = [
    inputs.glide.homeModules.default
  ];
  programs.glide-browser = {
    enable = true;
    nativeMessagingHosts = [ pkgs.ff2mpv ];
    # TODO: bookmarks
  };
}
