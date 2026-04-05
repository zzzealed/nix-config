{ config, ... }:
{
  age.secrets."hbd-ftps_rclone-config".file = ../../secrets/hbd-ftps_rclone-config.age;
  # From: https://wiki.nixos.org/wiki/Rclone
  environment.etc."rclone-mnt.conf".source = config.age.secrets."hbd-ftps_rclone-config".path;
  fileSystems."/mnt/hbd" = {
    device = "hbd:/home/zzzealed/";
    fsType = "rclone";
    options = [
      "nodev"
      "nofail"
      "allow_other"
      "args2env"
      "config=/etc/rclone-mnt.conf"
    ];
  };
}
