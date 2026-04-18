{ config, pkgs, ... }:
{
  services.forgejo = {
    enable = true;
    package = pkgs.forgejo;
    settings = {
      server = {
        DOMAIN = "git.l.zzzealed.com";
        ROOT_URL = "https://git.l.zzzealed.com";
        HTTP_PORT = 3333;
      };
      service.DISABLE_REGISTRATION = true;
    };
  };
  services.nginx = {
    virtualHosts."git.l.zzzealed.com" = {
      useACMEHost = "zzzealed.com";
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:${toString config.services.forgejo.settings.server.HTTP_PORT}";
    };
  };
}
