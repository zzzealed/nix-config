{ config, ... }:
{
  age.secrets."proton-1_private-key-file".file = ../../secrets/proton-1_private-key-file.age;
  networking.wg-quick.interfaces.wg_proton-1 = {
    address = [
      "10.2.0.2/32"
      "2a07:b944::2:2/128"
    ];
    autostart = false;
    dns = [
      config.nameserver.server
      config.nameserver.secondary
    ];
    listenPort = 51820;
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
    privateKeyFile = config.age.secrets."proton-1_private-key-file".path;
  };
}
