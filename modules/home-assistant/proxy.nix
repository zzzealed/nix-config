{ hosts, ... }:
{
  services.nginx.virtualHosts."ha.l.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://${hosts.rpi1.wgIp}:8123";
      proxyWebsockets = true;
      extraConfig = ''
        proxy_buffering off;
      '';
    };
  };
}
