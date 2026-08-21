{ ... }:
{
  programs.lan-mouse.settings = {
    authorized_fingerprints = {
      "42:66:b0:fc:97:12:7a:bc:e2:d1:9b:ca:bb:35:23:c4:bd:3e:75:7c:24:c3:6a:2b:83:e4:7e:d0:8f:6f:b0:f9" =
        "desktop";
    };
    clients = [
      {
        position = "right";
        hostname = "desktop";
        ips = [ "192.168.0.146" ];
        activate_on_startup = true;
      }
    ];
  };
}
