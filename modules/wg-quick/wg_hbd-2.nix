{ config, ... }:

{
  age.secrets."hbd-wireguard_config-2".file = ../../secrets/hbd-wireguard_config-2.age;
  networking.firewall.allowedTCPPorts = [ 41775 ]; # Port-forwarded at HBD
  networking.firewall.allowedUDPPorts = [ 41775 ];
  networking.wg-quick.interfaces = {
    wg_hbd-2 = {
      configFile = config.age.secrets."hbd-wireguard_config-2".path;
      autostart = true; # Automatically start the interface at boot
    };
  };
}
