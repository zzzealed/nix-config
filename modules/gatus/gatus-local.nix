{ config, ... }:
{
  services.gatus.settings.endpoints = [
    {
      name = "Router";
      group = "192.168.0.1";
      url = "http://192.168.0.1";
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
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
        "[RESPONSE_TIME] < 500"
        "[IP] == 192.168.0.104"
      ];
      alerts = [
        { type = "discord"; }
        { type = "ntfy"; }
      ];
    }
    # *.l.zzzealed.com (local)
    {
      name = "Vaultwarden";
      group = "l.zzzealed.com";
      url = "https://vault.l.zzzealed.com/alive";
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
        "[CERTIFICATE_EXPIRATION] > 336h"
      ];
      alerts = [
        { type = "discord"; }
        { type = "ntfy"; }
      ];
    }
    {
      name = "SearXNG";
      group = "l.zzzealed.com";
      url = "https://searx.l.zzzealed.com/healthz";
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
        "[BODY] == OK" # ok
        "[CERTIFICATE_EXPIRATION] > 336h"
      ];
      alerts = [
        { type = "discord"; }
        { type = "ntfy"; }
      ];
    }
    {
      name = "Karakeep";
      group = "l.zzzealed.com";
      url = "https://karakeep.l.zzzealed.com/api/health";
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
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
      group = "l.zzzealed.com";
      url = "https://scrutiny.l.zzzealed.com/api/summary";
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
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
      group = "l.zzzealed.com";
      url = "https://pihole.l.zzzealed.com/api/stats/summary";
      headers = {
        "X-FTL-SID" = "$\{PIHOLE_PASSWORD}";
      };
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
        "[BODY].queries.total > 0" # We are receiving queries
        "[BODY].gravity.domains_being_blocked > 0" # We are using blocklists
        "[CERTIFICATE_EXPIRATION] > 336h"
      ];
      alerts = [
        { type = "discord"; }
        { type = "ntfy"; }
      ];
    }
    {
      name = "Radicale";
      group = "l.zzzealed.com";
      url = "https://radicale.l.zzzealed.com";
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
        "[CERTIFICATE_EXPIRATION] > 336h"
      ];
      alerts = [
        { type = "discord"; }
        { type = "ntfy"; }
      ];
    }
    {
      name = "Home Assistant";
      group = "l.zzzealed.com";
      url = "https://ha.l.zzzealed.com/api/config";
      headers = {
        "Authorization" = "Bearer $\{HASS_TOKEN}";
      };
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
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
      group = "l.zzzealed.com";
      url = "https://change.l.zzzealed.com/api/v1/systeminfo";
      headers = {
        "x-api-key" = "$\{CHANGEDETECTION_KEY}";
      };
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
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
      name = "n8n";
      group = "l.zzzealed.com";
      url = "https://n8n.l.zzzealed.com/healthz";
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
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
      group = "l.zzzealed.com";
      url = "https://chrome.l.zzzealed.com/#shared";
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
        "[CERTIFICATE_EXPIRATION] > 336h"
      ];
      alerts = [
        { type = "discord"; }
        { type = "ntfy"; }
      ];
    }
    {
      name = "GPT4Free";
      group = "l.zzzealed.com";
      url = "https://g4f.l.zzzealed.com/v1/models";
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
        "[BODY].data != []" # We have models
        "[CERTIFICATE_EXPIRATION] > 336h"
      ];
      alerts = [
        { type = "discord"; }
        { type = "ntfy"; }
      ];
    }
    {
      name = "Teapot";
      group = "l.zzzealed.com";
      url = "https://twitter.l.zzzealed.com/.health";
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
        "[BODY].sessions.total > 0"
        "[CERTIFICATE_EXPIRATION] > 336h"
      ];
      alerts = [
        { type = "discord"; }
        { type = "ntfy"; }
      ];
    }
    {
      name = "Redlib";
      group = "l.zzzealed.com";
      url = "https://reddit.l.zzzealed.com/info";
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
        "[CERTIFICATE_EXPIRATION] > 336h"
      ];
      alerts = [
        { type = "discord"; }
        { type = "ntfy"; }
      ];
    }
    {
      name = "Harmonia";
      group = "l.zzzealed.com";
      url = "https://cache.l.zzzealed.com/health";
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
        "[BODY] == OK"
        "[CERTIFICATE_EXPIRATION] > 336h"
      ];
      alerts = [
        { type = "discord"; }
        { type = "ntfy"; }
      ];
    }
    {
      name = "pr-tracker";
      group = "l.zzzealed.com";
      url = "https://pr-tracker.l.zzzealed.com";
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
        "[BODY] == pat(*Nixpkgs Pull Request Tracker*)"
        "[CERTIFICATE_EXPIRATION] > 336h"
      ];
      alerts = [
        { type = "discord"; }
        { type = "ntfy"; }
      ];
    }
    {
      name = "Ollama";
      group = "l.zzzealed.com";
      url = "https://ollama.l.zzzealed.com";
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
        "[BODY] == Ollama is running"
        "[CERTIFICATE_EXPIRATION] > 336h"
      ];
      alerts = [
        { type = "discord"; }
        { type = "ntfy"; }
      ];
    }
    {
      name = "ntfy";
      group = "l.zzzealed.com";
      url = "https://ntfy.l.zzzealed.com/v1/health";
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
        "[BODY].healthy == true" # true
      ];
      alerts = [
        { type = "discord"; }
        { type = "ntfy"; }
      ];
    }
  ];
  services.nginx.virtualHosts."status.l.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations."/".proxyPass = "http://127.0.0.1:${toString config.services.gatus.settings.web.port}";
  };
}
