{ ... }:
{
  services.vaultwarden = {
    enable = true;
    dbBackend = "sqlite";
    backupDir = ""; # TODO: vault?
    config = {
      DOMAIN = "https://vault.l.zzzealed.com";
      SIGNUPS_ALLOWED = false;
    };
  };
}
