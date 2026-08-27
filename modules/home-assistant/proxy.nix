{ config, ... }:
{
  services.nginx.virtualHosts."ha.l.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations = {
      "/" = {
        proxyPass = "http://10.100.0.3:8123";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_buffering off;
        '';
      };
    };
  };
}
