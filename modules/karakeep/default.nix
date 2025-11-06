{ config, ... }:
{
  services.karakeep = {
    enable = true;
    extraEnvironment = {
      PORT = "7890";
      DISABLE_SIGNUPS = "true";
      DISABLE_NEW_RELEASE_CHECK = "true";
    };
  };
  networking.firewall = { allowedTCPPorts = [ 7890 ]; };
  services.nginx = {
    virtualHosts."karakeep.l.zzzealed.com" = {
      useACMEHost = "zzzealed.com";
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:${toString config.services.karakeep.extraEnvironment.PORT}";
    };
  };
}
