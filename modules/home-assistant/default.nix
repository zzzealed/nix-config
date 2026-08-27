{ pkgs, ... }:
{
  services.home-assistant = {
    enable = true;
    openFirewall = true;
    package = pkgs.home-assistant;
    customComponents = [
      pkgs.home-assistant-custom-components.auth_oidc
    ];
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
      # ???
      "androidtv_remote"
      "hue"
      "cast"
      "apple_tv"
      # "yale" # aiounittest-1.5.0 not supported for interpreter python3.14
    ];
    extraPackages =
      python3Packages: with python3Packages; [
        # recorder postgresql support
        psycopg2
        joserfc
      ];
    config = {
      default_config = { };
      http = {
        server_port = 8123;
        trusted_proxies = [
          "10.100.0.1"
        ];
        use_x_forwarded_for = true;
      };
      auth_oidc = {
        client_id = "homeassistant";
        discovery_url = "https://auth.l.zzzealed.com/.well-known/openid-configuration";
      };
      frontend = { };
      api = { };
    };
  };
}
