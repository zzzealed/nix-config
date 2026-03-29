{ ... }:
{
  imports = [ ./docker-compose.nix ];
  services.nginx = {
    virtualHosts."chrome.l.zzzealed.com" = {
      useACMEHost = "zzzealed.com";
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:3000";
    };
  };
}
