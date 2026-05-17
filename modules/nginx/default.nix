{ pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
  networking.firewall.allowedUDPPorts = [ 443 ];
  services.nginx = {
    enable = true;
    package = pkgs.nginxStable;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    commonHttpConfig = ''
      map $http_upgrade $connection_upgrade {
        default upgrade;
        ""      close;
      }
    '';
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "zzzealed@proton.me";
  };
  users.users.nginx.extraGroups = [ "acme" ];
}
