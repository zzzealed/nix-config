{ config, pkgs, ... }:
{
  age.secrets."speedtest-tracker_app-key-file".file =
    ../../secrets/speedtest-tracker_app-key-file.age;

  services.speedtest-tracker = {
    enable = true;
    package = pkgs.speedtest-tracker;
    settings = {
      APP_URL = "https://speedtest.l.zzzealed.com";
      APP_KEY_FILE = config.age.secrets."speedtest-tracker_app-key-file".path;
    };
    enableNginx = true;
    virtualHost = "speedtest.l.zzzealed.com";
  };
  services.nginx.virtualHosts."speedtest.l.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    # locations."/".proxyPass = "http://127.0.0.1:${config.services.speedtest-tracker.package}";
  };
}
