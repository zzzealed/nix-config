{ config, ... }:
{
  age.secrets."porkbun-nginx_api_key".file = ../../secrets/porkbun-nginx_api_key.age;
  age.secrets."porkbun-nginx_api_secret".file = ../../secrets/porkbun-nginx_api_secret.age;

  services.nginx.virtualHosts."zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    root = "/";
  };
  security.acme.certs."zzzealed.com" = {
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
}
