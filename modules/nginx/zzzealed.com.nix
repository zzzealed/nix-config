{ config, ... }:
let
  website = builtins.fetchGit {
    url = "https://codeberg.org/zzzealed/zzzealed.com";
    rev = "f48af8109d90b1ae689a18af39e5e53777d2db7c";
  };
in
{
  age.secrets."porkbun-nginx_api_key".file = ../../secrets/porkbun-nginx_api_key.age;
  age.secrets."porkbun-nginx_api_secret".file = ../../secrets/porkbun-nginx_api_secret.age;

  services.nginx.virtualHosts."zzzealed.com" = {
    default = true;
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    root = website;
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
