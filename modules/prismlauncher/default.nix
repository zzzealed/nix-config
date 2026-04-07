{ inputs, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.unstable.prismlauncher
    #inputs.prismlauncher.packages.${pkgs.stdenv.hostPlatform.system}.prismlauncher
  ];
}
