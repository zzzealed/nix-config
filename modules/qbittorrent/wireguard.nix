{ config, ... }:
{
  age.secrets."proton-2_private-key-file".file = ../../secrets/proton-2_private-key-file.age;
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
    checkReversePath = "loose";
  };
  networking.wireguard.interfaces.wg_proton-2 = {
    ips = [
      "10.2.0.2/32"
      "2a07:b944::2:2/128"
    ];
    listenPort = 51820;
    privateKeyFile = config.age.secrets."proton-2_private-key-file".path;
    allowedIPsAsRoutes = false;
    peers = [
      {
        publicKey = "fJt+VGA6v6VoXWZ0pxf6XQWZFUH/5A4tPLxMMWasHzI=";
        allowedIPs = [
          "0.0.0.0/0"
          "::/0"
        ];
        endpoint = "149.88.109.33:51820";
        persistentKeepalive = 25;
      }
    ];
  };
  systemd.services.qbittorrent = {
    after = [ "wireguard-wg_proton-2.target" ];
    requires = [ "wireguard-wg_proton-2.target" ];
  };
}
