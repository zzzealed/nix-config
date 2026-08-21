{ ... }:
{
  programs.lan-mouse.settings = {
    authorized_fingerprints = {
      "e2:a4:fc:ee:56:03:36:4e:58:0d:b9:93:2e:36:e7:76:3f:f5:7e:38:d0:63:09:e3:a7:ed:3d:9d:1e:59:90:96" =
        "laptop";
    };
    clients = [
      {
        position = "left";
        hostname = "laptop";
        ips = [ "192.168.0.133" ];
        activate_on_startup = true;
      }
    ];
  };
}
