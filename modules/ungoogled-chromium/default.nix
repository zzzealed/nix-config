{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.unstable.ungoogled-chromium ];
}
