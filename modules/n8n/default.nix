{ pkgs, config, ... }:
{
  services.n8n = {
    enable = true;
    #package = pkgs.n8n;
    #openFirewall = true;
    environment = {
      N8N_PORT = 5678;
    };
  };
  services.nginx = {
    virtualHosts."n8n.l.zzzealed.com" = {
      useACMEHost = "zzzealed.com";
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:${toString config.services.n8n.environment.N8N_PORT}";
    };
  };
}
