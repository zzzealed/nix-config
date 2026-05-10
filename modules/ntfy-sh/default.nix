{ config, pkgs, ... }:
{
  services.ntfy-sh = {
    enable = true;
    package = pkgs.ntfy-sh;
    settings = {
      base-url = "https://ntfy.l.zzzealed.com";
      listen-http = ":8181";
    };
  };
  services.nginx.virtualHosts."ntfy.l.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1${config.services.ntfy-sh.settings.listen-http}";
      proxyWebsockets = true;
    };
  };
}
