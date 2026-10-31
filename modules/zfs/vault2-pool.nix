{ ... }:
{
  boot.zfs.requestEncryptionCredentials = false;
  custom.zfs.bindMounts.pool = "vault2";
}
