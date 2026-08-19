{ config, ... }:
{
  age.secrets."samba-secrets".file = ../../secrets/samba-secrets.age;
  fileSystems."/mnt/vault2" = {
    device = "//pi.l.zzzealed.com/vault2";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in
      [ "${automount_opts},credentials=${config.age.secrets."samba-secrets".path},uid=1000,gid=100" ];
  };
}
