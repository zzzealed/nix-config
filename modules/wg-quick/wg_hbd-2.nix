{ config, ... }:
{
  age.secrets."hbd-2_private-key-file".file = ../../secrets/hbd-2_private-key-file.age;
  networking.firewall = {
    allowedUDPPorts = [ 21841 ];
    checkReversePath = "loose";
  };
  networking.wireguard.interfaces.wg_hbd-2 = {
    ips = [ "10.107.2.3/24" ];
    listenPort = 21841;
    privateKeyFile = config.age.secrets."hbd-2_private-key-file".path;
    allowedIPsAsRoutes = false;
    peers = [
      {
        publicKey = "dSJPSHB+5k4TyYQ2eMtOrlncGyaTDyqFvMzLVRrcQ0Q=";
        endpoint = "45.87.251.50:51072";
        allowedIPs = [ "0.0.0.0/0" ];
        persistentKeepalive = 25;
      }
    ];
  };
  systemd.services.qbittorrent.unitConfig.After = [ "wireguard-wg_hbd-2.target" ];
}
