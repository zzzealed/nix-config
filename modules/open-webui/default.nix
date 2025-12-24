{ config, pkgs, ... }:
{
  services.open-webui = {
    enable = true;
    # This app is a piece of shiiiiiiiiiiiittt
    package = pkgs.unstable.open-webui;
    #package = pkgs.open-webui;
    port = 11111;
    #openFirewall = true;
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      OPENAI_API_BASE_URL = "https://g4f.l.zzzealed.com/v1"; # GPT4Free instance, shhh
      #OPENAI_API_BASE_URLS = "https://g4f.l.zzzealed.com/api/Perplexity;https://g4f.l.zzzealed.com/api/PollinationsAI";
      ENABLE_SIGNUP = "False";
      DEFAULT_MODELS = "deepseek-v3";
      ENABLE_PERSISTENT_CONFIG = "True"; # We need this I guess?
      ENABLE_VERSION_UPDATE_CHECK = "False";
      ENABLE_WEB_SEARCH = "True";
      WEB_SEARCH_ENGINE = "searxng";
      SEARXNG_QUERY_URL = "https://searx.l.zzzealed.com/search?q=<query>"; # Remember to enable JSON on SearXNG instance
    };
  };
  services.nginx = {
    virtualHosts."chat.l.zzzealed.com" = {
      useACMEHost = "zzzealed.com";
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:${toString config.services.open-webui.port}";
      locations."/".proxyWebsockets = true;
    };
  };
}
