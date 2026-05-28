{ config, ... }:
{
  age.secrets."hbd-1_private-key-file".file = ../../secrets/hbd-1_private-key-file.age;
  networking.firewall = {
    allowedUDPPorts = [ 21841 ];
    checkReversePath = "loose";
  };
  networking.wg-quick.interfaces.wg_hbd-1 = {
    autostart = false;
    address = [ "10.107.2.1/24" ]; # client VPN IP
    listenPort = 21841;
    privateKeyFile = config.age.secrets."hbd-1_private-key-file".path;
    dns = [ "192.168.0.118" ];
    peers = [
      {
        publicKey = "dSJPSHB+5k4TyYQ2eMtOrlncGyaTDyqFvMzLVRrcQ0Q=";
        endpoint = "45.87.251.50:51072";
        allowedIPs = [ "0.0.0.0/0" ];
        persistentKeepalive = 25;
      }
    ];
    postUp = [
      "ip rule add to 192.168.0.0/24 table main priority 500"
      "ip rule add to 10.0.0.0/8 table main priority 510"
      "ip rule add to 172.16.0.0/12 table main priority 520"
    ];
    postDown = [
      "ip rule del to 192.168.0.0/24 table main priority 500"
      "ip rule del to 10.0.0.0/8 table main priority 510"
      "ip rule del to 172.16.0.0/12 table main priority 520"
    ];
  };
}
