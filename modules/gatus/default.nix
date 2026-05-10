{ config, pkgs, ... }:
{
  age.secrets."gatus_environment-file".file = ../../secrets/gatus_environment-file.age;

  services.gatus = {
    enable = true;
    package = pkgs.gatus;
    environmentFile = config.age.secrets."gatus_environment-file".path;
    settings.web.port = 8080;
    settings.alerting = {
      discord = {
        webhook-url = "$\{DISCORD_WEBHOOK}";
        default-alert = {
          enabled = true;
          failure-threshold = 2; # We wait 10 mins
          success-threshold = 1; # We're so back
          send-on-resolved = true;
        };
      };
      ntfy = {
        url = "https://ntfy.l.zzzealed.com";
        topic = "gatus";
        default-alert = {
          enabled = true;
          failure-threshold = 2;
          success-threshold = 1;
          send-on-resolved = true;
        };
      };
    };
  };
}
