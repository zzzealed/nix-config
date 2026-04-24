{ config, ... }:
{
  age.secrets."vps-nixos_ddclient_config".file = ../../secrets/vps-nixos_ddclient_config.age;
  services.ddclient = {
    configFile = config.age.secrets."vps-nixos_ddclient_config".path;
  };
}
