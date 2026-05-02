{ config, pkgs, ... }:
{
  age.secrets."harmonia_sign-key".file = ../../secrets/harmonia_sign-key.age;

  services.harmonia = {
    enable = true;
    package = pkgs.harmonia;
    signKeyPaths = [ config.age.secrets."harmonia_sign-key".path ];
    # Public: cache.l.zzzealed.com-1:d29SnNbB+hmWUlqbc6TaYaOP8fv25hlxpQRxgCqLQhE=
    settings.bind = "[::]:5050";
    nix.settings.allowed-users = [ "harmonia" ];
  };
  services.nginx.virtualHosts."cache.l.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations."/".proxyPass = "http://127.0.0.1:5050";
  };
}
