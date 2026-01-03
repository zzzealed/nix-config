{ inputs, pkgs, ... }:
{
  environment.systemPackages = [ inputs.prismlauncher.packages.${pkgs.system}.prismlauncher ];
}
