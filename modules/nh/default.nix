{ inputs, system, ... }:
{
  programs.nh = {
    enable = true;
    package = inputs.nh.packages.${system}.nh;
  };
}
