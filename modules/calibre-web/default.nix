{ config, pkgs, ... }:
{
  services.calibre-web = {
    enable = true;
    #openFirewall = true;
    package = pkgs.calibre-web;
    listen.ip = "0.0.0.0";
    listen.port = 8083;
    options = {
      enableBookUploading = true;
      enableBookConversion = true;
      #calibreLibrary = "/vault/Documents/Books"; # TODO: ?
    };
  };
  services.nginx = {
    virtualHosts."calibre.l.zzzealed.com" = {
      useACMEHost = "zzzealed.com";
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:${toString config.services.calibre-web.listen.port}";
    };
  };
}
