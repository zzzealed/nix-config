{ config, pkgs, ... }:
{
  services.open-webui = {
    enable = true;
    package = pkgs.open-webui;
    openFirewall = true;
    host = "0.0.0.0";
    port = 11111;
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      OPENAI_API_BASE_URL = "http://server.l.zzzealed.com:9090/v1";
    };
  };
  services.nginx = {
    virtualHosts."chat.l.zzzealed.com" = {
      useACMEHost = "zzzealed.com";
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:${toString config.services.open-webui.port}";
    };
  };
}
