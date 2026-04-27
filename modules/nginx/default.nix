{ pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [ 443 ];
  services.nginx = {
    enable = true;
    package = pkgs.nginxStable;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "zzzealed@proton.me";
  };
  users.users.nginx.extraGroups = [ "acme" ];
}
