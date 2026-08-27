{ config, ... }:
{
  age.secrets."pi-nixos_ddclient_config".file = ../../secrets/pi-nixos_ddclient_config.age;
  services.ddclient = {
    configFile = config.age.secrets."pi-nixos_ddclient_config".path;
  };
}
