{ config, pkgs, ... }:
{
  age.secrets."gatus_environment-file".file = ../../secrets/gatus_environment-file.age;

  services.gatus = {
    enable = true;
    package = pkgs.gatus;
    #openFirewall = true;
    environmentFile = config.age.secrets."gatus_environment-file".path; 
    settings.web.port = 8080;
    settings = {
      alerting = {
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
          url = "https://ntfy.rotte.city";
          topic = "gatus";
          default-alert = {
            enabled = true;
            failure-threshold = 2;
            success-threshold = 1;
            send-on-resolved = true;
          };
        };
      };
      endpoints = [
        # TEST
#        {
#          name = "TEST";
#          url = "https://google.com";
#          interval = "1m";
#          conditions = [
#            "[STATUS] == 404"
#          ];
#          alerts = [
#            { type = "discord"; }
#            { type = "ntfy"; }
#          ];
#        }
        # Misc (local)
        {
          name = "Router";
          group = "192.168.0.1";
          url = "http://192.168.0.1";
          interval = "5m";
          conditions = [
            "[STATUS] == 200"
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
            "[IP] == 192.168.0.1"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
        {
          name = "JetKVM";
          group = "192.168.0.104";
          url = "http://192.168.0.104";
          interval = "5m";
          conditions = [
            "[STATUS] == 200"
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
            "[IP] == 192.168.0.104"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
         
        # *.rotte.city (public)
        {
          name = "Website 2";
          group = "rotte.city";
          url = "https://rotte.city";
          interval = "5m";
          conditions = [
            "[STATUS] == 404" # Intentional
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
            # LEGO renews every 30 days
            "[CERTIFICATE_EXPIRATION] > 336h" # 14 days
            # I have Porkbuns's "Early Auto Renew (45 days)" turned on 
            "[DOMAIN_EXPIRATION] > 336h" # 14 days
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
        {
          name = "ntfy";
          group = "ntfy.rotte.city";
          url = "https://ntfy.rotte.city/v1/health";
          interval = "5m";
          conditions = [
            "[STATUS] == 200"
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
            "[BODY].healthy == true" # true 
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
        {
          name = "DDNS 2";
          group = "vps.rotte.city";
          url = "icmp://vps.rotte.city";
          interval = "5m";
          conditions = [
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
            # So we know if IP changes, for funsies
            "[IP] == 79.76.44.104"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
        {
          name = "DDNS";
          group = "ddns.rotte.city";
          url = "icmp://ddns.rotte.city";
          interval = "5m";
          conditions = [
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
            # So we know if IP changes, for funsies
            "[IP] == 87.104.105.54"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
        {
          name = "Rust gameserver";
          group = "rust.rotte.city";
          url = "udp://rust.rotte.city:28015";
          interval = "5m";
          conditions = [
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }

        # *.zzzealed.com (public)
        {
          name = "Website";
          group = "zzzealed.com";
          url = "https://zzzealed.com";
          interval = "5m";
          conditions = [
            "[STATUS] == 200"
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
            # LEGO renews every 30 days
            "[CERTIFICATE_EXPIRATION] > 336h" # 14 days
            # I have Porkbuns's "Early Auto Renew (45 days)" turned on 
            "[DOMAIN_EXPIRATION] > 336h"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
        {
          name = "Forgejo";
          group = "git.zzzealed.com";
          url = "https://git.zzzealed.com/api/healthz";
          interval = "5m";
          conditions = [
            "[STATUS] == 200"
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
            "[BODY].checks.cache:ping[0].status == pass" # Cache is pass
            "[BODY].checks.database:ping[0].status == pass" # Database is pass
            "[CERTIFICATE_EXPIRATION] > 336h"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }

        # *.l.zzzealed.com (local)
        {
          name = "Vaultwarden";
          group = "vault.l.zzzealed.com";
          url = "https://vault.l.zzzealed.com/alive";
          interval = "5m";
          conditions = [
            "[STATUS] == 200"
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
            "[CERTIFICATE_EXPIRATION] > 336h"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
        {
          name = "SearXNG";
          group = "searx.l.zzzealed.com";
          url = "https://searx.l.zzzealed.com/healthz";
          interval = "5m";
          conditions = [
            "[STATUS] == 200"
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
            "[BODY] == OK" # ok
            "[CERTIFICATE_EXPIRATION] > 336h"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
        {
          name = "OpenWebUI";
          group = "chat.l.zzzealed.com";
          url = "https://chat.l.zzzealed.com/health";
          interval = "5m";
          conditions = [
            "[STATUS] == 200"
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
            "[BODY].status == true" # true
            "[CERTIFICATE_EXPIRATION] > 336h"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
        {
          name = "Karakeep";
          group = "karakeep.l.zzzealed.com";
          url = "https://karakeep.l.zzzealed.com/api/health";
          interval = "5m";
          conditions = [
            "[STATUS] == 200"
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
            "[BODY].status == ok" # ok
            "[CERTIFICATE_EXPIRATION] > 336h"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
        {
          name = "Scrutiny";
          group = "scrutiny.l.zzzealed.com";
          url = "https://scrutiny.l.zzzealed.com/api/summary";
          interval = "5m";
          conditions = [
            "[STATUS] == 200"
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
            "[BODY].success == true" # ? everything good ig
            "[BODY].data.summary.0x5002538f4372fee6.device.device_status == 0" # Our disks have no errors
            "[BODY].data.summary.0x5002538f4372feeb.device.device_status == 0"
            "[BODY].data.summary.0x5002538f4372feee.device.device_status == 0"
            "[BODY].data.summary.0x5002538f4372fef1.device.device_status == 0"
            "[BODY].data.summary.0x5002538f4381ec2d.device.device_status == 0"
            "[CERTIFICATE_EXPIRATION] > 336h"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
        {
          name = "Pihole";
          group = "pihole.l.zzzealed.com";
          url = "https://pihole.l.zzzealed.com/api/stats/summary";
          headers = {
            "X-FTL-SID" = "$\{PIHOLE_PASSWORD}";
          };
          interval = "5m";
          conditions = [
            "[STATUS] == 200"
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
            "[BODY].queries.total > 0" # We are receiving queries
            "[BODY].gravity.domains_being_blocked > 0"  # We are using blocklists
            "[CERTIFICATE_EXPIRATION] > 336h"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
        {
          name = "Radicale";
          group = "radicale.l.zzzealed.com";
          url = "https://radicale.l.zzzealed.com";
          interval = "5m";
          conditions = [
            "[STATUS] == 200"
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
            "[CERTIFICATE_EXPIRATION] > 336h"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
        {
          name = "Home Assistant";
          group = "ha.l.zzzealed.com";
          url = "https://ha.l.zzzealed.com/api/config";
          headers = {
            "Authorization" = "Bearer $\{HASS_TOKEN}";
          };
          interval = "5m";
          conditions = [
            "[STATUS] == 200"
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
            "[BODY].state == RUNNING" # This will do
            "[CERTIFICATE_EXPIRATION] > 336h"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
        {
          name = "ChangeDetection";
          group = "change.l.zzzealed.com";
          url = "https://change.l.zzzealed.com/api/v1/systeminfo";
          headers = {
            "x-api-key" = "$\{CHANGEDETECTION_KEY}";
          };
          interval = "5m";
          conditions = [
            "[STATUS] == 200"
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
            "[BODY].uptime > 0" # Hopefully this works
            "[BODY].watch_count > 0"
            "[CERTIFICATE_EXPIRATION] > 336h"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
        {
          name = "Calibre Web";
          group = "calibre.l.zzzealed.com";
          url = "https://calibre.l.zzzealed.com";
          interval = "5m";
          conditions = [
            "[STATUS] == 200"
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
            "[CERTIFICATE_EXPIRATION] > 336h"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
        {
          name = "n8n";
          group = "n8n.l.zzzealed.com";
          url = "https://n8n.l.zzzealed.com/healthz";
          interval = "5m";
          conditions = [
            "[STATUS] == 200"
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
            "[BODY].status == ok" # ok
            "[CERTIFICATE_EXPIRATION] > 336h"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
        {
          name = "Chrome";
          group = "chrome.l.zzzealed.com";
          url = "https://chrome.l.zzzealed.com";
          interval = "5m";
          conditions = [
            "[STATUS] == 200"
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
            "[CERTIFICATE_EXPIRATION] > 336h"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
        {
          name = "GPT4Free";
          group = "g4f.l.zzzealed.com";
          url = "https://g4f.l.zzzealed.com/v1/models";
          interval = "5m";
          conditions = [
            "[STATUS] == 200"
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
            "[BODY].data != []" # We have models
            "[CERTIFICATE_EXPIRATION] > 336h"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
        {
          name = "SSH";
          group = "SSH";
          url = "ssh://ddns.rotte.city:2267";
          interval = "5m";
          conditions = [
            "[STATUS] == 0"
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
        {
          name = "Wireguard";
          group = "Wireguard";
          url = "udp://ddns.rotte.city:51820";
          interval = "5m";
          conditions = [
            "[CONNECTED] == true"
            "[RESPONSE_TIME] < 300"
          ];
          alerts = [
            { type = "discord"; }
            { type = "ntfy"; }
          ];
        }
      ];
    };
  };
  services.nginx = {
    virtualHosts."status.rotte.city" = {
      useACMEHost = "rotte.city";
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:${toString config.services.gatus.settings.web.port}";
    };
  };
}
