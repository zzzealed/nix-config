{ config, ... }:
{
  age.secrets."ddclient_config".file = ../../secrets/ddclient_config.age;
  services.ddclient = {
    enable = true;
    configFile = config.age.secrets."ddclient_config".path;
  };
}
