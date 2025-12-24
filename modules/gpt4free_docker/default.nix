{ ... }:
{
  services.nginx = {
    virtualHosts."g4f.l.zzzealed.com" = {
      useACMEHost = "zzzealed.com";
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:9090";
    };
  };
}
