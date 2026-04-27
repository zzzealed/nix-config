{ pkgs, config, ... }:
{
  services.changedetection-io = {
    enable = true;
    package = pkgs.changedetection-io;
    behindProxy = true;
    #webDriverSupport = true;
    listenAddress = "0.0.0.0";
    port = 5000;
  };
  #networking.firewall = { allowedTCPPorts = [ config.services.changedetection-io.port ]; };
  services.nginx = {
    virtualHosts."change.l.zzzealed.com" = {
      useACMEHost = "zzzealed.com";
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:${toString config.services.changedetection-io.port}";
    };
  };
}
