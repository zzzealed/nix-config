{ config, ... }:

{
  age.secrets."pi-4_private-key-file".file = ../../secrets/pi-4_private-key-file.age;
  networking.wg-quick.interfaces.wg_pi-4 = {
    address = [ "10.100.0.4/32" ];
    dns = [
      "192.168.0.118"
      "1.1.1.1"
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
    privateKeyFile = config.age.secrets."pi-4_private-key-file".path;
  };
}
