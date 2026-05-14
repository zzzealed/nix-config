{ config, pkgs, ... }:
{
  services.qbittorrent = {
    enable = true;
    package = pkgs.qbittorrent-nox;
    torrentingPort = 41775;
    webuiPort = 1337;
    serverConfig = {
      Preferences = {
        WebUI = {
          Username = "mads";
          Password_PBKDF2 = "@ByteArray(Lq+hF/JGD3e0oludEJ2xcQ==:n56jFApNg89rJMHKbq7c6nUkUA0C0xG8TFQ6eOV8I20TlZQP6jxc6IoBoSJcDgGZFNH/pU73Wxz0sBSJgV2Dqg==)";
        };
        Advanced = {
          NetworkInterface = "wg_hbd-2";
        };
      };
    };
  };
  services.nginx.virtualHosts."qbit.l.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations."/".proxyPass = "http://127.0.0.1:${toString config.services.qbittorrent.webuiPort}";
  };
}
