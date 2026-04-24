{ config, ... }:

{
  age.secrets."desktop-nixos_wireguard_config".file = ../../secrets/desktop-nixos_wireguard_config.age;
  networking.wg-quick.interfaces = {
    wg_pi-nixos = {
      configFile = config.age.secrets."desktop-nixos_wireguard_config".path; 
      autostart = false;  # Automatically start the interface at boot
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
