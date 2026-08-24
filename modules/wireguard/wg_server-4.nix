{ config, ... }:

{
  age.secrets."server-4_private-key-file".file = ../../secrets/server-4_private-key-file.age;
  networking.wg-quick.interfaces.wg_server-4 = {
    address = [ config.wireguard.allowedIPs.vps ];
    dns = [
      config.nameserver.server
      config.nameserver.secondary
    ];
    listenPort = 51820;
    autostart = true;
    peers = [
      {
        publicKey = "/BwFcBg+woiYHkVGkg9B3Lu9fBe3VhTE5h+yM83390s=";
        endpoint = "home.zzzealed.com:51820";
        allowedIPs = [
          "10.100.0.0/24"
          "192.168.0.0/24"
        ];
        persistentKeepalive = 25;
      }
    ];
    privateKeyFile = config.age.secrets."server-4_private-key-file".path;
  };
}
