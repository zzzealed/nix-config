{ config, ... }:
let
  website = builtins.fetchGit {
    url = "https://codeberg.org/zzzealed/rotte.city";
    rev = "25d4d6faefa686e51c1191bef8870d7bc5e62213";
  };
in
{
  age.secrets."porkbun-nginx_api_key".file = ../../secrets/porkbun-nginx_api_key.age;
  age.secrets."porkbun-nginx_api_secret".file = ../../secrets/porkbun-nginx_api_secret.age;

  services.nginx.virtualHosts."rotte.city" = {
    default = true;
    useACMEHost = "rotte.city";
    forceSSL = true;
    root = website;
    locations."/health" = {
      return = ''200 "ok"'';
      extraConfig = ''
        access_log off;
        add_header Content-Type text/plain;
      '';
    };
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
