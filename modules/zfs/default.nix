{ pkgs, ... }:
{
  boot.supportedFilesystems = [ "zfs" ];
  environment.systemPackages = [ pkgs.zfs ];
  boot.zfs.forceImportRoot = false; # Import with `sudo zpool import (-l) vault`

  services.zfs.autoSnapshot = {
    enable = true;
    weekly = 2;
  };
}
