{ config, ... }:
{
  services.gatus.settings.external-endpoints = [
    {
      name = "Actions check-no-build.yml workflow";
      group = "github.com";
      token = "$\{GATUS_GITHUB_TOKEN}";
      alerts = [
        {
          type = "discord";
          failure-threshold = 1;
        }
        {
          type = "ntfy";
          failure-threshold = 1;
        }
      ];
    }
    {
      name = "Actions build.yml workflow";
      group = "github.com";
      token = "$\{GATUS_GITHUB_TOKEN}";
      alerts = [
        {
          type = "discord";
          failure-threshold = 1;
        }
        {
          type = "ntfy";
          failure-threshold = 1;
        }
      ];
    }
  ];
  services.gatus.settings.endpoints = [
    # *.rotte.city (public)
    {
      name = "Website 2";
      group = "rotte.city";
      url = "https://rotte.city/health";
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
        "[BODY] == ok" # ok
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
      name = "Rust gameserver";
      group = "rotte.city";
      url = "udp://rust.rotte.city:28015";
      interval = "5m";
      conditions = [
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
      ];
      alerts = [
        { type = "discord"; }
        { type = "ntfy"; }
      ];
    }
    {
      name = "SSH";
      group = "rotte.city";
      url = "ssh://ssh.rotte.city:2267";
      interval = "5m";
      conditions = [
        "[STATUS] == 0"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
      ];
      alerts = [
        { type = "discord"; }
        { type = "ntfy"; }
      ];
    }
    {
      name = "Wireguard";
      group = "zzzealed.com";
      url = "udp://wg.zzzealed.com:51820";
      interval = "5m";
      conditions = [
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
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
      url = "https://zzzealed.com/health";
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
        "[BODY] == ok" # ok
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
      name = "DDNS 2";
      group = "zzzealed.com";
      url = "1.1.1.1";
      interval = "5m";
      dns = {
        query-name = "vps.zzzealed.com";
        query-type = "A";
      };
      conditions = [
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
        # So we know if IP changes, for funsies
        "[BODY] == 79.76.44.104"
        "[DNS_RCODE] == NOERROR"
      ];
      alerts = [
        { type = "discord"; }
        { type = "ntfy"; }
      ];
    }
    {
      name = "DDNS";
      group = "zzzealed.com";
      url = "1.1.1.1";
      interval = "5m";
      dns = {
        query-name = "home.zzzealed.com";
        query-type = "A";
      };
      conditions = [
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
        # So we know if IP changes, for funsies
        "[BODY] == 87.104.105.54"
        "[DNS_RCODE] == NOERROR"
      ];
      alerts = [
        { type = "discord"; }
        { type = "ntfy"; }
      ];
    }
    {
      name = "Forgejo";
      group = "zzzealed.com";
      url = "https://git.zzzealed.com/api/healthz";
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
        "[BODY].checks.cache:ping[0].status == pass" # Cache is pass
        "[BODY].checks.database:ping[0].status == pass" # Database is pass
        "[CERTIFICATE_EXPIRATION] > 336h"
      ];
      alerts = [
        { type = "discord"; }
        { type = "ntfy"; }
      ];
    }
    {
      name = "Gatus";
      group = "l.zzzealed.com";
      url = "https://status.l.zzzealed.com/health";
      interval = "5m";
      conditions = [
        "[STATUS] == 200"
        "[CONNECTED] == true"
        "[RESPONSE_TIME] < 500"
        "[BODY].status == UP"
        "[CERTIFICATE_EXPIRATION] > 336h"
      ];
      alerts = [
        { type = "discord"; }
        { type = "ntfy"; }
      ];
    }
  ];
  services.nginx.virtualHosts."status.rotte.city" = {
    useACMEHost = "rotte.city";
    forceSSL = true;
    locations."/".proxyPass = "http://127.0.0.1:${toString config.services.gatus.settings.web.port}";
  };
}
