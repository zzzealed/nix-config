{ system, inputs, ... }:
{
  environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1"; # https://wiki.nixos.org/wiki/Firefox#Wayland_support
  environment.systemPackages = [
    inputs.glide-browser.packages.${system}.default
  ];
}
