{ config, pkgs, ... }:
{
  services.pihole-web = {
    enable = true;
    package = pkgs.pihole-web;
    ports = [ 8181 ];
  };
  services.pihole-ftl = {
    enable = true;
    package = pkgs.pihole-ftl;
    piholePackage = pkgs.pihole;
    #openFirewallWebserver = true;
    openFirewallDNS = true;
    settings = { # From: https://github.com/pi-hole/FTL/blob/master/test/pihole.toml
      dns = {
        upstreams = [ "127.0.0.1#5335" ]; # Unbound instance
        hosts = [
          "192.168.0.118 server.l.zzzealed.com"
          "192.168.0.151 pi.l.zzzealed.com"
          "192.168.0.146 desktop.l.zzzealed.com"
          "192.168.0.31 laptop2.l.zzzealed.com"
          "192.168.0.164 phone.l.zzzealed.com"
        ];
        dnssec = true; ### CHANGED, default = false
        listeningMode = "ALL"; ### CHANGED, default = "LOCAL"
        cnameRecords = [
          "vault.l.zzzealed.com,server.l.zzzealed.com"
          "glance.l.zzzealed.com,server.l.zzzealed.com"
          "wg.l.zzzealed.com,server.l.zzzealed.com"
          "pihole.l.zzzealed.com,server.l.zzzealed.com"
          "ha.l.zzzealed.com,server.l.zzzealed.com"
          "scrutiny.l.zzzealed.com,server.l.zzzealed.com"
          "chat.l.zzzealed.com,server.l.zzzealed.com"
          "searx.l.zzzealed.com,server.l.zzzealed.com"
          "mc.l.zzzealed.com,server.l.zzzealed.com"
          "change.l.zzzealed.com,server.l.zzzealed.com"
          "chrome.l.zzzealed.com,server.l.zzzealed.com"
          "karakeep.l.zzzealed.com,server.l.zzzealed.com"
          "n8n.l.zzzealed.com,server.l.zzzealed.com"
          "calibre.l.zzzealed.com,server.l.zzzealed.com"
          "g4f.l.zzzealed.com,server.l.zzzealed.com"
          "radicale.l.zzzealed.com,server.l.zzzealed.com"
          "git.l.zzzealed.com,server.l.zzzealed.com"
        ];
      };
      webserver.api = {
        pwhash = "$BALLOON-SHA256$v=1$s=1024,t=32$tJm1oUkrwSOPVZlAVeGqjA==$zksJz7atbt39Mw2DoqeFOCqwzO8Rd8ayH1N7JZwGGBI="; ### CHANGED, default = ""
        app_pwhash = "$BALLOON-SHA256$v=1$s=1024,t=32$tJm1oUkrwSOPVZlAVeGqjA==$zksJz7atbt39Mw2DoqeFOCqwzO8Rd8ayH1N7JZwGGBI=";
        #totp_secret = "";
      };
    };
    lists = [ # From: https://firebog.net
      # Suspicious Lists
      { url = "https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt"; }
      { url = "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts"; }
      { url = "https://v.firebog.net/hosts/static/w3kbl.txt"; }
      { url = "https://raw.githubusercontent.com/matomo-org/referrer-spam-blacklist/master/spammers.txt"; }
      { url = "https://someonewhocares.org/hosts/zero/hosts"; }
      { url = "https://raw.githubusercontent.com/VeleSila/yhosts/master/hosts"; }
      { url = "https://winhelp2002.mvps.org/hosts.txt"; }
      { url = "https://v.firebog.net/hosts/neohostsbasic.txt"; }
      { url = "https://raw.githubusercontent.com/RooneyMcNibNug/pihole-stuff/master/SNAFU.txt"; }
      { url = "https://paulgb.github.io/BarbBlock/blacklists/hosts-file.txt"; }

      # Advertising Lists
      { url = "https://adaway.org/hosts.txt"; }
      { url = "https://v.firebog.net/hosts/AdguardDNS.txt"; }
      { url = "https://v.firebog.net/hosts/Admiral.txt"; }
      { url = "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt"; }
      { url = "https://v.firebog.net/hosts/Easylist.txt"; }
      { url = "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext"; }
      { url = "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts"; }
      { url = "https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts"; }

      # Tracking & Telemetry Lists
      { url = "https://v.firebog.net/hosts/Easyprivacy.txt"; }
      { url = "https://v.firebog.net/hosts/Prigent-Ads.txt"; }
      { url = "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts"; }
      { url = "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt"; }
      { url = "https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt"; }
      { url = "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/android-tracking.txt"; }
      { url = "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV.txt"; }
      { url = "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/AmazonFireTV.txt"; }
      { url = "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-blocklist.txt"; }

      # Malicious Lists
      { url = "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt"; }
      { url = "https://v.firebog.net/hosts/Prigent-Crypto.txt"; }
      { url = "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts"; }
      { url = "https://bitbucket.org/ethanr/dns-blacklists/raw/8575c9f96e5b4a1308f2f12394abd86d0927a4a0/bad_lists/Mandiant_APT1_Report_Appendix_D.txt"; }
      { url = "https://phishing.army/download/phishing_army_blocklist_extended.txt"; }
      { url = "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt"; }
      { url = "https://v.firebog.net/hosts/RPiList-Malware.txt"; }
      { url = "https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt"; }
      { url = "https://raw.githubusercontent.com/AssoEchap/stalkerware-indicators/master/generated/hosts"; }
      { url = "https://urlhaus.abuse.ch/downloads/hostfile/"; }
      { url = "https://lists.cyberhost.uk/malware.txt"; }
      { url = "https://malware-filter.gitlab.io/malware-filter/phishing-filter-hosts.txt"; }
      { url = "https://v.firebog.net/hosts/Prigent-Malware.txt"; }
      { url = "https://raw.githubusercontent.com/jarelllama/Scam-Blocklist/main/lists/wildcard_domains/scams.txt"; }
      { url = "https://v.firebog.net/hosts/RPiList-Phishing.txt"; }

      # Other Lists
      { url = "https://raw.githubusercontent.com/anudeepND/blacklist/master/facebook.txt"; }
    ];
  };
  services.nginx = {
    virtualHosts."pihole.l.zzzealed.com" = {
      useACMEHost = "zzzealed.com";
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:${toString config.services.pihole-web.ports}";
    };
  };
}
