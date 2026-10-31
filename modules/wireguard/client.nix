{ config, hosts, ... }:
{
  networking.wg-quick.interfaces.wg-server = {
    address = [ hosts.${config.networking.hostName}.wgIp ];
    autostart = true;
    dns = [
      "10.100.0.1"
      "1.1.1.1"
      "1.0.0.1"
    ];
    peers = [
      {
        publicKey = "ShK/VV+el3nb6oGqpDIhJIVLgDQMucTASV6gGeIMwyw=";
        endpoint = "wg.zzzealed.com:${toString hosts.srv1.wgPort}";
        persistentKeepalive = 25;
        allowedIPs = [
          hosts.srv1.wgSubnet
          hosts.router1.lanSubnet
        ];
      }
    ];
    privateKeyFile = config.age.secrets."private-key-file".path;
  };
  age.secrets."private-key-file".file =
    ../../secrets/wireguard-server/${config.networking.hostName}_private-key-file.age;
}
