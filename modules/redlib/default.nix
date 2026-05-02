{
  inputs,
  config,
  pkgs,
  ...
}:
{
  services.redlib = {
    enable = true;
    package = inputs.redlib.packages.${pkgs.stdenv.hostPlatform.system}.default;
    port = 6969;
    settings = {
      REDLIB_ENABLE_RSS = "on";
      REDLIB_FULL_URL = "https://reddit.l.zzzealed.com";
    };
  };
  services.nginx.virtualHosts."reddit.l.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations."/".proxyPass = "http://127.0.0.1:${toString config.services.redlib.port}";
  };
}
