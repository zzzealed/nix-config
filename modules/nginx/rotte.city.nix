{ config, ... }:
{
  age.secrets."porkbun-nginx_api_key".file = ../../secrets/porkbun-nginx_api_key.age;
  age.secrets."porkbun-nginx_api_secret".file = ../../secrets/porkbun-nginx_api_secret.age;

  services.nginx.virtualHosts."rotte.city" = {
    default = true;
    useACMEHost = "rotte.city";
    forceSSL = true;
    root = "/";
    locations."/".return = "404";
  };
  security.acme.certs."rotte.city" = {
    domain = "rotte.city";
    extraDomainNames = [ 
      "*.rotte.city" # Public, set via Porkbun DNS
    ];
    dnsProvider = "porkbun"; # Provider of DNS-challenge
    dnsPropagationCheck = true;
    credentialFiles = {
      PORKBUN_API_KEY_FILE = config.age.secrets."porkbun-nginx_api_key".path;
      PORKBUN_SECRET_API_KEY_FILE = config.age.secrets."porkbun-nginx_api_secret".path;
    };    
  };
}
