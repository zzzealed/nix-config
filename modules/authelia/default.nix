{ config, pkgs, ... }:
{
  age.secrets."authelia_jwt-secret-file" = {
    file = ../../secrets/authelia_jwt-secret-file.age;
    owner = "authelia-main";
  };
  age.secrets."authelia_storage-encryption-key-file" = {
    file = ../../secrets/authelia_storage-encryption-key-file.age;
    owner = "authelia-main";
  };

  services.authelia.instances.main = {
    enable = true;
    package = pkgs.authelia;
    secrets = {
      jwtSecretFile = config.age.secrets."authelia_jwt-secret-file".path;
      storageEncryptionKeyFile = config.age.secrets."authelia_storage-encryption-key-file".path;
    };
    settings = {
      theme = "auto";
      default_2fa_method = "totp";
      log.level = "info";
      server.address = "tcp://:9091/";
      session = {
        same_site = "lax";
        cookies = [
          {
            domain = "zzzealed.com";
            authelia_url = "https://auth.l.zzzealed.com";
          }
        ];
      };
      access_control = {
        default_policy = "deny";
        rules = [
          # API health endpoints
          {
            # This is not a *great* way to do this. I should be doing it per-domain but I can't be arsed
            domain = "*.l.zzzealed.com";
            policy = "bypass";
            resources = [
              # I still hate regex
              "^/alive/?$"
              "^/healthz/?$"
              "^/api/health/?$"
              "^/api/summary/?$"
              "^/api/stats/summary/?$"
              "^/api/config/?$"
              "^/api/v1/systeminfo/?$"
              "^/v1/models/?$"
              "^/\\.health/?$"
              "^/info/?$"
              "^/health/?$"
              "^/v1/health/?$"
              "^/api/v2/transfer/info/?$"
              "^/[^/]+/rss/?$"
            ];
          }
          # Exceptions
          {
            domain = "auth.l.zzzealed.com";
            policy = "bypass";
          }
          # Protect everything else
          {
            domain = "*.l.zzzealed.com";
            policy = "one_factor";
          }
        ];
      };
      storage.local.path = "/var/lib/authelia-main/db.sqlite";
      notifier.filesystem.filename = "/var/lib/authelia-main/notifications.yml";
      authentication_backend.file.path = "/etc/authelia/users.yml";
    };
  };
  environment.etc."authelia/users.yml" = {
    mode = "0400";
    user = "authelia-main";
    text = ''
      users:
        mads:
          password: "$argon2id$v=19$m=65536,t=3,p=4$nPnluxT0n7nkZlBJZDMHng$OBfFbP488IuRgsnfAPqZqxl6CQro4tOQ+8lj/cd/w74"
          displayname: "Mads"
          email: "zzzealed@proton.me"
          groups: ["admins"]
    '';
  };
  services.nginx.virtualHosts."auth.l.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations."/".proxyPass = "http://127.0.0.1:9091";
  };
}
