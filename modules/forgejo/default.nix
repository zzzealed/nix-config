{ config, pkgs, ... }:
{
  services.forgejo = {
    enable = true;
    package = pkgs.forgejo;
    settings = {
      server = {
        DOMAIN = "git.zzzealed.com";
        ROOT_URL = "https://git.zzzealed.com";
        HTTP_PORT = 3333;
      };
      service = {
        DISABLE_REGISTRATION = true;
        ALLOW_ONLY_EXTERNAL_REGISTRATION = true;
        SHOW_REGISTRATION_BUTTON = false;
      };
      openid = {
        ENABLE_OPENID_SIGNIN = false;
        ENABLE_OPENID_SIGNUP = true;
        WHITELISTED_URIS = "auth.l.zzzealed.com";
      };
      cors = {
        ENABLED = true;
        ALLOW_ORIGIN = "https://zzzealed.com";
      };
    };
  };
  services.nginx.virtualHosts."git.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations."/".proxyPass =
      "http://127.0.0.1:${toString config.services.forgejo.settings.server.HTTP_PORT}";
  };
}
