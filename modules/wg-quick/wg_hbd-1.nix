{ config, ... }:

{
  age.secrets."hbd-wireguard_config-1".file = ../../secrets/hbd-wireguard_config-1.age;
  networking.firewall.allowedTCPPorts = [ 41314 ]; # Port-forwarded at HBD  
  networking.wg-quick.interfaces = {
    wg_hbd-1 = {
      configFile = config.age.secrets."hbd-wireguard_config-1".path; 
      autostart = false;  # Automatically start the interface at boot
      # Local access, eg. for a PiHole instance.
      # Will cause DNS-leaks, but I don't mind. I think.
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
