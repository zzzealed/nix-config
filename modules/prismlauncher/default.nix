{ inputs, pkgs, ... }:
{
  environment.systemPackages = [ inputs.prismlauncher.packages.${pkgs.stdenv.hostPlatform.system}.prismlauncher ];
}
