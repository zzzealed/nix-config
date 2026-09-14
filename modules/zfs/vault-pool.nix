{ ... }:
{
  boot.zfs.extraPools = [ "vault" ];
  custom.zfs.bindMounts.pool = "vault";
}
