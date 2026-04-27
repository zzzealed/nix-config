{ pkgs, config, ... }:
{
  services.scrutiny = {
    enable = true;
    package = pkgs.scrutiny;
    #openFirewall = true;
    settings.web.listen.port = 50236;
  };
  services.nginx = {
    virtualHosts."scrutiny.l.zzzealed.com" = {
      useACMEHost = "zzzealed.com";
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:${toString config.services.scrutiny.settings.web.listen.port}";
    };
  };
}
