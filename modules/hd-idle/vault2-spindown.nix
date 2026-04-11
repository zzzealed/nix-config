{ pkgs, ... }:
{
  systemd.services.vault2-spindown = {
    description = "External HD spin down daemon";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple"; # hd-idle 1.05+ no longer forks
      ExecStart = "${pkgs.hd-idle}/bin/hd-idle -i 0 -a usb-Seagate_Expansion+_Desk_NAAC04AL-0:0 -i 300"; # 300 seconds to spindown
    };
  };
}
