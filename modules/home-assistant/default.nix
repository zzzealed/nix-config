{ config, pkgs, ... }:
{
  services.home-assistant = {
    enable = true;
    openFirewall = true;
    package = pkgs.unstable.home-assistant;
    extraComponents = [
      # Components required to complete the onboarding
      "analytics"
      "google_translate"
      "met"
      "radio_browser"
      "shopping_list"
      # Recommended for fast zlib compression
      # https://www.home-assistant.io/integrations/isal
      "isal"
    ];
    config = {
      default_config = {};
      http = {
        server_port = 8123;
        use_x_forwarded_for = true;
        trusted_proxies = [
          "127.0.0.1" # Add the IP address of the proxy server
          "172.18.0.0/16" # You may also provide the subnet mask
        ];
      };
    };
  };
  services.nginx = {
    virtualHosts."ha.l.zzzealed.com" = {
      useACMEHost = "zzzealed.com";
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:${toString config.services.home-assistant.config.http.server_port}";
    };
  };
}
