{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.openconnect_openssl ];
}
