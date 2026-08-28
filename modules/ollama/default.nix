{ config, pkgs, ... }:
{
  services.ollama = {
    enable = true;
    package = pkgs.unstable.ollama-cuda;
    port = 11434;
    loadModels = [ ];
    syncModels = true;
  };
  services.nginx.virtualHosts."ollama.l.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations."/" = {
      recommendedProxySettings = false;
      proxyPass = "http://127.0.0.1:${toString config.services.ollama.port}";
      extraConfig = ''
        proxy_set_header Host localhost:11434;
      '';
    };
  };
}
