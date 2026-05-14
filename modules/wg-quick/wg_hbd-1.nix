{ config, ... }:
{
  age.secrets."hbd-1_private-key-file".file = ../../secrets/hbd-1_private-key-file.age;
  networking.firewall = {
    checkReversePath = "loose";
  };
  networking.wireguard.interfaces.wg_hbd-1 = {
    ips = [ "10.107.2.2/24" ];
    listenPort = 21841;
    privateKeyFile = config.age.secrets."hbd-1_private-key-file".path;
    allowedIPsAsRoutes = false;
    peers = [
      {
        publicKey = "dSJPSHB+5k4TyYQ2eMtOrlncGyaTDyqFvMzLVRrcQ0Q=";
        endpoint = "45.87.251.50:51072";
        allowedIPs = [ "0.0.0.0/0" ];
        persistentKeepalive = 25;
      }
    ];
    postSetup = [
      "ip rule add from 192.168.0.0/16 table main prio 10"
      "ip rule add from 172.17.0.0/16 table main prio 20"
      "ip rule add from 172.16.0.0/12 table main prio 30"
      # Route DNS queries to PiHole via main table
      "ip rule add to 192.168.0.118 table main prio 5"
    ];
    postShutdown = [
      "ip rule del from 192.168.0.0/16"
      "ip rule del from 172.17.0.0/16"
      "ip rule del from 172.16.0.0/12"
      "ip rule del to 192.168.0.118"
    ];
  };
}
