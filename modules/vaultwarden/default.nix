{ pkgs, config, ... }:
{
  services.vaultwarden = {
    enable = true;
    package = pkgs.vaultwarden;
    dbBackend = "sqlite";
    #backupDir = ""; # TODO: vault?
    config = {
      DOMAIN = "https://vault.l.zzzealed.com";
      SIGNUPS_ALLOWED = false;
      ROCKET_PORT = 8222;
    };
  };
  services.nginx.virtualHosts."vault.l.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations."/".proxyPass =
      "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
    locations."/".proxyWebsockets = true;
  };
}
