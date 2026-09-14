{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom.zfs.bindMounts = {
    pool = lib.mkOption {
      type = lib.types.str;
      example = "vault";
      description = "ZFS pool the mounts live on";
    };
    mounts = lib.mkOption {
      type = lib.types.attrsOf lib.types.path;
      default = { };
      description = ''
        Pool-relative path -> local mountpoint.
        The directory must exist on the pool before the mount unit is generated.
      '';
      example = {
        "/services/qbittorrent" = "/var/lib/qBittorrent/qBittorrent";
      };
    };
  };

  config = {
    fileSystems = builtins.listToAttrs (
      lib.mapAttrsToList (poolPath: mountpoint: {
        name = toString mountpoint;
        value = {
          device = "/${config.custom.zfs.bindMounts.pool}${poolPath}";
          fsType = "none";
          options = [ "bind" ];
          depends = [ "/${config.custom.zfs.bindMounts.pool}" ];
        };
      }) config.custom.zfs.bindMounts.mounts
    );

    boot.supportedFilesystems = [ "zfs" ];
    environment.systemPackages = [ pkgs.zfs ];
    boot.zfs.forceImportRoot = lib.mkDefault true;

    services.zfs.autoSnapshot = {
      enable = true;
      weekly = 2;
    };
  };
}
