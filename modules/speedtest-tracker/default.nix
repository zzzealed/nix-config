{ config, pkgs, ... }:
{
  services.speedtest-tracker = {
    enable = true;
    package = pkgs.speedtest-tracker;
    settings = {
      APP_URL = "https://speedtest.l.zzzealed.com";
    };
  };
  services.nginx.virtualHosts."speedtest.l.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations."/".proxyPass = "http://127.0.0.1:${toString config.services.speedtest-tracker.package}";
  };
}
