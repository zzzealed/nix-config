{
  routers = {
    router = {
      ssid = "Waoo4920_NCF8";
      lanIp = "192.168.0.1";
      subnet = "/24";
    };
    router2 = {
      ssid = "rottenet";
      lanIp = "192.168.8.1";
      subnet = "/24";
    };
  };
  server = {
    hostId = "adb2c089";
    lanIp = "192.168.0.118";
    iface = "enp3s0";
    router = "router";
    wgIp = "10.100.0.1";
  };
  desktop = {
    hostId = "19fa2096";
    lanIp = "192.168.8.2";
    iface = "eno2";
    router = "router2";
    wgIp = "10.100.0.2";
  };
  pi = {
    hostId = "cf20a29f";
    lanIp = "192.168.8.3";
    iface = "enu1u1u1";
    router = "router2";
    wgIp = "10.100.0.3";
  };
  vps = {
    hostId = "2c363b2d";
    lanIp = "10.0.0.241";
    iface = "ens3";
    wgIp = "10.100.0.4";
  };
  laptop = {
    hostId = "4115249e";
    lanIp = "192.168.8.5";
    iface = "";
    wgIp = "10.100.0.5";
  };
  phone = {
    lanIp = "192.168.8.6";
    wgIp = "10.100.0.6";
  };
}
