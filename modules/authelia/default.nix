{ config, pkgs, ... }:
{
  # https://github.com/NixOS/nixpkgs/blob/master/nixos/tests/authelia.nix
  #
  age.secrets."authelia_jwt-secret-file".file = ../../secrets/authelia_jwt-secret-file.age;
  age.secrets."authelia_storage-encryption-key-file".file =
    ../../secrets/authelia_storage-encryption-key-file.age;

  services.authelia.instances.main = {
    enable = true;
    package = pkgs.authelia;
    secrets = {
      jwtSecretFile = config.age.secrets."authelia_jwt-secret-file".path;
      storageEncryptionKeyFile = config.age.secrets."authelia_storage-encryption-key-file".path;
    };
    settings = {
      server.address = "tcp://:9091/";
      session.cookies = [
        {
          domain = "l.zzzealed.com";
          authelia_url = "https://auth.l.zzzealed.com";
        }
      ];
      access_control.default_policy = "one-factor";
      storage.local.path = "/var/lib/authelia-main/db.sqlite";
      notifier.filesystem.filename = "/var/lib/authelia-main/notifications.yml";
      authentication_backend.file.path = "/var/lib/authelia-main/users.yml";
    };
  };
  services.nginx.virtualHosts."auth.l.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations."/".proxyPass = "http://127.0.0.1:9091";
  };
}
