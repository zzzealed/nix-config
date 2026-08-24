{ config, pkgs, ... }:
{
  services.actual = {
    enable = true;
    package = pkgs.actual-server;
    settings = {
      hostname = "127.0.0.1";
      port = 3033;
    };
  };
  services.nginx.virtualHosts."actual.l.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations."/".proxyPass = "http://127.0.0.1:${toString config.services.actual.settings.port}";
  };
}
