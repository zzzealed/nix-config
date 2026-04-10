{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.unstable.prismlauncher ];
}
