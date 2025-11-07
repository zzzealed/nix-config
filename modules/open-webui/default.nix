{ config, pkgs, ... }:
{
  services.open-webui = {
    enable = true;
    package = pkgs.unstable.open-webui;
    port = 11111;
    #openFirewall = true;
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      OPENAI_API_BASE_URL = "http://server.l.zzzealed.com:9090/v1"; # GPT4Free instance, shhh
      ENABLE_SIGNUP = "True";
      DEFAULT_MODELS = "deepseek-v3";
      ENABLE_PERSISTENT_CONFIG = "True"; # We need this to keep users
      ENABLE_VERSION_UPDATE_CHECK = "False";
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
