{ ... }:
{
  boot.zfs.extraPools = [ "vault2" ];
  boot.zfs.forceImportRoot = false; # Import with `sudo zpool import (-l) vault2`
  custom.zfs.bindMounts.pool = "vault2";
}
