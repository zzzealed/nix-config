{ config, ... }:
{
  networking.wireguard.interfaces.wg-proton = {
    ips = [
      "10.2.0.2/32"
      "2a07:b944::2:2/128"
    ];
    peers = [
      {
        publicKey = "gTQp+FBWOlQc6zqsZj8mT5qDZfDv688UY5RnUoBgIlo=";
        allowedIPs = [
          "0.0.0.0/0"
          "::/0"
        ];
        endpoint = "66.234.146.98:51820";
        persistentKeepalive = 25;
      }
    ];
    privateKeyFile = config.age.secrets."server-proton_private-key-file".path;
    listenPort = 51821;
    allowedIPsAsRoutes = false;
  };
  age.secrets."server-proton_private-key-file".file =
    ../../secrets/server-proton_private-key-file.age;
  networking.firewall = {
    allowedUDPPorts = [ 51821 ];
    checkReversePath = "loose";
  };
}
