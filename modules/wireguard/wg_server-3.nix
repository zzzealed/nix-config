{ config, ... }:
{
  age.secrets."server-3_private-key-file".file = ../../secrets/server-3_private-key-file.age;
  networking.wg-quick.interfaces.wg_server-3 = {
    address = [
      config.wireguard.allowedIPs.desktop
    ];
    autostart = false;
    dns = [
      config.nameserver.server
      config.nameserver.secondary
    ];
    listenPort = 51820;
    peers = [
      {
        publicKey = "/BwFcBg+woiYHkVGkg9B3Lu9fBe3VhTE5h+yM83390s=";
        allowedIPs = [
          "0.0.0.0/0"
          "::/0"
        ];
        endpoint = "home.zzzealed.com:51820";
        persistentKeepalive = 25;
      }
    ];
    privateKeyFile = config.age.secrets."server-3_private-key-file".path;
  };
}
