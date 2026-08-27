{ config, ... }:
{
  networking.wg-quick.interfaces.wg-proton = {
    address = [
      "10.2.0.2/32"
      "2a07:b944::2:2/128"
    ];
    autostart = false;
    dns = [
      "10.2.0.1"
      "2a07:b944::2:1"
    ];
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
    privateKeyFile = config.age.secrets."laptop-proton_private-key-file".path;
  };
  age.secrets."laptop-proton_private-key-file".file =
    ../../secrets/laptop-proton_private-key-file.age;
}
