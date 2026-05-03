{ config, ... }:
let
  website = builtins.fetchGit {
    url = "https://codeberg.org/zzzealed/zzzealed.com";
    rev = "6985b7c13ff7bb9e34dcad67929733d04b0c25cd";
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

  # Redirect to external Gatus instance
  services.nginx.virtualHosts."status.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations."/".return = "301 https://status.rotte.city/endpoints/zzzealed-com_website";
  };

  security.acme.certs."zzzealed.com" = {
    domain = "zzzealed.com";
    extraDomainNames = [
      "*.zzzealed.com" # Public, set via Porkbun DNS
      "*.l.zzzealed.com" # Local, set via Pihole
    ];
    dnsProvider = "porkbun"; # Provider of DNS-challenge
    dnsPropagationCheck = true;
    credentialFiles = {
      PORKBUN_API_KEY_FILE = config.age.secrets."porkbun-nginx_api_key".path;
      PORKBUN_SECRET_API_KEY_FILE = config.age.secrets."porkbun-nginx_api_secret".path;
    };
  };
}
