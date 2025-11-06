{ config, ... }:
{
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  age.secrets."porkbun-nginx_api_key".file = ../../secrets/porkbun-nginx_api_key.age;
  age.secrets."porkbun-nginx_api_secret".file = ../../secrets/porkbun-nginx_api_secret.age;
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts = { # This is just an example. I usually set this per-service in their respective module.
      "zzzealed.com" = {
        useACMEHost = "zzzealed.com";
        forceSSL = true;
        root = "/";
      };
    };
  };
  # TODO: TLS reverse-proxy?
  security.acme = {
    acceptTerms = true;
    defaults.email = "zzzealed@proton.me";
    certs."zzzealed.com" = {
      domain = "zzzealed.com";
      extraDomainNames = [ 
        "*.zzzealed.com"
        "*.l.zzzealed.com"
      ];
      dnsProvider = "porkbun";
      dnsPropagationCheck = true;
      credentialFiles = {
        PORKBUN_API_KEY_FILE = config.age.secrets."porkbun-nginx_api_key".path;
        PORKBUN_SECRET_API_KEY_FILE = config.age.secrets."porkbun-nginx_api_secret".path;
      };
    };
  };
  users.users.nginx.extraGroups = [ "acme" ];
}
