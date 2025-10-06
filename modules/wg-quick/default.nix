{ ... }:

{
  networking.wg-quick.interfaces = {
    wg0 = {
      configFile = "/etc/wireguard/wg0.conf";  # Path to your wg0.conf file
      autostart = true;  # Automatically start the interface at boot
      # Local access
      postUp = [ 
        "ip rule add from 192.168.0.0/16 table main prio 10"
        "ip rule add from 172.17.0.0/16 table main prio 20"
        "ip rule add from 172.16.0.0/12 table main prio 30"
      ];
      postDown = [
        "ip rule del from 192.168.0.0/16"
        "ip rule del from 172.17.0.0/16"
        "ip rule del from 172.16.0.0/12"
      ];
    };
  };
}
