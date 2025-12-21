{ stdenv, inputs, ... }:
{
  #imports = [ inputs.nixpkgs-wayland.overlays.default ];
  programs.wayvnc = {
    enable = true;
    #package = inputs.nixpkgs-wayland.packages.${stdenv.hostPlatform.system}.wayvnc;
  };
  networking.firewall = { allowedTCPPorts = [ 5900 ]; };
}
