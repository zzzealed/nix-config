{ pkgs, inputs, ... }:
{
  programs.nh = {
    enable = true;
    package = pkgs.unstable.nh;
    #package = inputs.nh.packages.${pkgs.stdenv.hostPlatform.system}.nh;
  };
}
