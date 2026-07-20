{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    package = (
      pkgs.obs-studio.override {
        cudaSupport = false;
        browserSupport = false; # For now
      }
    );
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
      obs-vkcapture
    ];
    enableVirtualCamera = true;
  };
}
