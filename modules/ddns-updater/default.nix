{ config, ... }:
{
  age.secrets."ddns-updater_config".file = ../../secrets/ddns-updater_config.age;
  services.ddns-updater = {
    enable = true;
    environment = {
      SERVER_ENABLED = "no";
      PERIOD = "5m";
      CONFIG_FILEPATH = config.age.secrets."ddns-updater_config".path;
    };
  };
}
