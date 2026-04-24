{ config, ... }:

{
  age.secrets."vps-nixos_wireguard_config".file = ../../secrets/vps-nixos_wireguard_config.age;
  networking.wg-quick.interfaces = {
    wg_pi-nixos = {
      configFile = config.age.secrets."vps-nixos_wireguard_config".path; 
      autostart = true;  # Automatically start the interface at boot
    };
  };
}
