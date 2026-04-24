{ config, ... }:
{
  age.secrets."server-nixos_ddclient_config".file = ../../secrets/server-nixos_ddclient_config.age;
  services.ddclient = {
    configFile = config.age.secrets."server-nixos_ddclient_config".path;
  };
}
