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
  age.secrets."authelia_oidc-hmac-secret-file" = {
    file = ../../secrets/authelia_oidc-hmac-secret-file.age;
    owner = "authelia-main";
  };
  age.secrets."authelia_oidc-issuer-private-key-file" = {
    file = ../../secrets/authelia_oidc-issuer-private-key-file.age;
    owner = "authelia-main";
  };

  services.authelia.instances.main = {
    enable = true;
    package = pkgs.authelia;
    secrets = {
      jwtSecretFile = config.age.secrets."authelia_jwt-secret-file".path;
      storageEncryptionKeyFile = config.age.secrets."authelia_storage-encryption-key-file".path;
      oidcHmacSecretFile = config.age.secrets."authelia_oidc-hmac-secret-file".path;
      oidcIssuerPrivateKeyFile = config.age.secrets."authelia_oidc-issuer-private-key-file".path;
    };
    settings = {
      theme = "auto";
      default_2fa_method = "webauthn";
      log.level = "info";
      server.address = "tcp://:9091/";
      session = {
        same_site = "lax";
        expiration = "6 hours";
        inactivity = "72h";
        remember_me = "365d";
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
          # Exceptions
          {
            domain = "auth.l.zzzealed.com";
            policy = "bypass";
          }
          {
            domain = "vault.l.zzzealed.com";
            policy = "bypass";
          }
          # Protect everything else
          {
            domain = "*.zzzealed.com";
            policy = "two_factor";
          }
          {
            domain = "*.l.zzzealed.com";
            policy = "two_factor";
          }
        ];
      };
      identity_providers = {
        oidc = {
          claims_policies = {
            karakeep = {
              id_token = [ "email" ];
            };
          };
          clients = [
            {
              client_id = "forgejo";
              # Generate with `authelia -c authelia crypto hash generate pbkdf2`
              client_secret = "$pbkdf2-sha512$310000$Z5XWq/yH3udVZn/gibDftA$F7NAXd7W/pxdm7iv//pZy7ODPTfDRsFMJWmja3fhIUi2iCva2Ni0DF9u3fOIf2li3qhWHKmKgvNeOYkzIKSb1A";
              redirect_uris = [ "https://git.zzzealed.com/user/oauth2/authelia/callback" ];
              scopes = [
                "openid"
                "email"
                "profile"
                "groups"
              ];
            }
            {
              client_id = "karakeep";
              client_name = "Karakeep";
              client_secret = "$pbkdf2-sha512$310000$Ei9k39F0Cxtm2HXweXtSiQ$iYww67U0V7ws.7R41N5jVW5C0roaKbg7jfmkoEn9F8tr5XfMPwsPElQtRXufTm8jkAhT92MnsyN7wfscbAwV2A";
              claims_policy = "karakeep";
              redirect_uris = [ "https://karakeep.l.zzzealed.com/api/auth/callback/custom" ];
              scopes = [
                "openid"
                "email"
                "profile"
                "groups"
              ];
            }
            {
              client_id = "homeassistant";
              client_name = "Home Assistant";
              public = true;
              require_pkce = true;
              pkce_challenge_method = "S256";
              redirect_uris = [ "https://ha.l.zzzealed.com/auth/oidc/callback" ];
              scopes = [
                "openid"
                "email"
                "profile"
                "groups"
              ];
            }
          ];
        };
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
