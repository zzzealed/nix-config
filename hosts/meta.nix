{
  routers = {
    router = {
      lanIp = "192.168.0.1";
      subnet = "/24";
    };
    router2 = {
      lanIp = "192.168.8.1";
      subnet = "/24";
    };
  };
  server = {
    lanIp = "192.168.0.118";
    iface = "enp3s0";
    router = "router";
    wgIp = "10.100.0.1";
  };
  desktop = {
    lanIp = "192.168.8.2";
    iface = "eno2";
    router = "router2";
    wgIp = "10.100.0.2";
  };
  pi = {
    lanIp = "192.168.8.3";
    iface = "enu1u1u1";
    router = "router2";
    wgIp = "10.100.0.3";
  };
  vps = {
    lanIp = "10.0.0.241";
    iface = "ens3";
    wgIp = "10.100.0.4";
  };
  laptop.wgIp = "10.100.0.5";
  phone.wgIp = "10.100.0.6";
}
