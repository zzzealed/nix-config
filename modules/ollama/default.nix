{ config, pkgs, ... }:
{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    acceleration = "cuda";
    port = 11434;
    loadModels = [
      "qwen3:0.6b"
      "qwen3:1.7b"
      "qwen2.5vl:3b"
    ];
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
