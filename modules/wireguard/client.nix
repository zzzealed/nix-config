{ config, lib, ... }:
{
  networking.wg-quick.interfaces.wg-server = {
    autostart = true;
    dns = [
      "10.100.0.1"
      "1.1.1.1"
      "1.0.0.1"
    ];
    peers = [
      {
        publicKey = "ShK/VV+el3nb6oGqpDIhJIVLgDQMucTASV6gGeIMwyw=";
        endpoint = "wg.zzzealed.com:${toString config.wireguard.serverPort}";
        persistentKeepalive = 25;
        # Split hosts use 10.100.0.0/24 + 192.168.0.0/24
        allowedIPs = config.wireguard.clientAllowedIPs;
      }
    ];
  };
}
