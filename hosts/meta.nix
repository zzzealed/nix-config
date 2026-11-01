{
  router1 = {
    description = "ISP router at server site";
    ssid = "Waoo4920_NCF8";
    lanIp = "192.168.0.1";
    lanSubnet = "192.168.0.0/24";
  };
  router2 = {
    description = "Third-party router at apartment";
    ssid = "rottenet";
    lanIp = "192.168.8.1";
    lanSubnet = "192.168.8.0/24";
  };
  srv1 = {
    description = "Dell R5500 server";
    hostId = "adb2c089";
    lanIp = "192.168.0.118";
    iface = "enp3s0";
    router = "router1";
    wgIp = "10.100.0.1";
    wgIface = "wg0";
    wgPort = 51820;
    wgSubnet = "10.100.0.0/16";
  };
  desktop1 = {
    description = "Desktop PC";
    hostId = "19fa2096";
    lanIp = "192.168.8.100";
    iface = "eno2";
    router = "router2";
    wgIp = "10.100.0.2";
  };
  rpi1 = {
    description = "Raspberry Pi 3B+ PC";
    hostId = "cf20a29f";
    lanIp = "192.168.8.3";
    iface = "enu1u1u1";
    router = "router2";
    wgIp = "10.100.0.3";
  };
  vps1 = {
    description = "Oracle free-tier virtual private server";
    hostId = "2c363b2d";
    lanIp = "10.0.0.241";
    iface = "ens3";
    wgIp = "10.100.0.4";
  };
  laptop1 = {
    description = "Huawei laptop";
    hostId = "4115249e";
    lanIp = "192.168.8.107";
    iface = "";
    wgIp = "10.100.0.5";
  };
  phone1 = {
    description = "Pixel 9a phone";
    lanIp = "192.168.8.6";
    wgIp = "10.100.0.6";
  };
}
