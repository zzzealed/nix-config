{ config, pkgs, ... }:
{
  services.qbittorrent = {
    enable = true;
    package = pkgs.qbittorrent-nox;
    torrentingPort = 41775;
    webuiPort = 1337;
  };
  services.nginx.virtualHosts."qbit.l.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations."/".proxyPass = "http://127.0.0.1:${toString config.services.qbittorrent.webuiPort}";
  };
}
