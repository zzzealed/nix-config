{ ... }:
{
  # From: https://wiki.nixos.org/wiki/Rclone
  environment.etc."rclone-mnt.conf".text = ''
    [hbd]
    type = ftp
    host = 38.ein.itsby.design
    user = zzzealed
    pass = IkOAU_Blaqibrb75mp3u7VHXSFbeU3LVsMyIo3FTilI
    explicit_tls = true
    no_check_certificate = true
  ''; # `pass` is "obscured". See: https://rclone.org/commands/rclone_obscure/
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
