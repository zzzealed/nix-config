{ pkgs, inputs, system, ... }:
{
  programs.nh = {
    enable = true;
    package = pkgs.unstable.nh;
    #package = inputs.nh.packages.${system}.nh;
  };
}
