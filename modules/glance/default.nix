{ inputs, ... }:
{
  imports = [ inputs.glance-ical-events.nixosModules.default ];
  services.glance = {
    enable = true;
    openFirewall = true;
    settings = {
      server.host = "0.0.0.0";
      server.port = 6789;
      theme = {
        disable-picker = false;
      };
      pages = [
          {
            name = "Page 1";
            columns = [
              {
                size = "small";
                widgets = [
                  {
                    type = "clock";
                    hour-format = "24h";
                    timezones = [
                      { timezone = "America/New_York"; }
                      { timezone = "America/Los_Angeles"; }
                    ];
                  }
                  {
                    type = "monitor";
                    cache = "5m";
                    sites = [
                      {
                        title = "Router";
                        url = "http://192.168.0.1";
                        icon = "sh:pfsense";
                      }
                      {
                        title = "JetKVM";
                        url = "http://192.168.0.104";
                        icon = "sh:jetkvm";
                      }
                      {
                        title = "Vaultwarden";
                        url = "http://192.168.0.118:8000";
                        icon = "sh:vaultwarden";
                      }
                      {
                        title = "SearXNG";
                        url = "http://192.168.0.118:8609";
                        icon = "sh:searxng";
                      }
                      {
                        title = "Open WebUI";
                        url = "http://192.168.0.118:11111";
                        icon = "sh:open-webui";
                      }
                      {
                        title = "PiHole";
                        url = "http://192.168.0.118:8181";
                        icon = "sh:pi-hole";
                      }
                      {
                        title = "Home Assistant";
                        url = "http://192.168.0.118:8123";
                        icon = "sh:home-assistant";
                      }
                      {
                        title = "ChangeDetection";
                        url = "http://192.168.0.118:5000";
                        icon = "sh:changedetection";
                      }
                      {
                        title = "Scrutiny";
                        url = "http://192.168.0.118:50236";
                        icon = "sh:scrutiny";
                      }
                    ];
                  }
                ];
              }
              {
                size = "full";
                widgets = [
                  {
                    type = "rss";
                    style = "detailed-list";
                    collapse-after = 5;
                    feeds = [
                      {
                        url = "https://selfh.st/rss";
                        title = "Selfh.st";
                      }
                      {
                        url = "https://noted.lol/tag/news/rss";
                        title = "NOTED";
                      }
                      {
                        url = "https://torrentfreak.com/feed";
                        title = "TorrentFreak";
                      }
                      {
                        url = "https://mullvad.net/en/blog/feed/atom";
                        title = "Mullvad";
                      }
                      {
                        url = "https://www.lttlabs.com/blog/rss.xml";
                        title = "LTT Labs";
                      }
                      {
                        url = "https://fmhy.net/feed.rss";
                        title = "FMHY";
                      }
                      {
                        url = "https://pivot-to-ai.com/feed";
                        title = "PivotToAI";
                      }
                      {
                        url = "https://richardlewis.substack.com/feed";
                        title = "Richard Lewis";
                      }
                      {
                        url = "https://unixdigest.com/feed.rss";
                        title = "unixdigest";
                      }
                      {
                        url = "https://xcancel.com/RLDailyShop/rss";
                        title = "RLDailyShop";
                      }
                      {
                        url = "https://xcancel.com/ShiftRLE/rss";
                        title = "ShiftRLE";
                      }
                      {
                        url = "https://determinate.systems/rss.xml";
                        title = "Determinate Systems";
                      }
                      {
                        url = "https://www.hltv.org/rss/news";
                        title = "HLTV";
                      }
                    ];
                  }
                  {
                    type = "group";
                    widgets = [
                      {
                        type = "lobsters";
                        limit = 20;
                        collapse-after = 10;
                        sort-by = "hot";
                      }
                      {
                        type = "hacker-news";
                        limit = 20;
                        collapse-after = 10;
                      }
                    ];
                  }
                ]; 
              }
              {
                size = "small";
                widgets = [
                  { type = "calendar"; }
                  {
                    type = "custom-api";
                    title = "CompApex calendar";
                    cache = "15m";
                    url = "http://0.0.0.0:8076/events";
                    parameters = {
                      url = "https://calendar.google.com/calendar/ical/9ad286735043bbfc1494408580cbe6246b9d92988537e4549053f9e6866d63b3%40group.calendar.google.com/public/basic.ics";
                      limit = 5;
                    };
                    template = builtins.readFile ./config/ical-events.file;
                  }
                  {
                    type = "custom-api";
                    title = "RLEsports iCal";
                    cache = "15m";
                    url = "http://0.0.0.0:8076/events";
                    parameters = {
                      url = "https://calendar.google.com/calendar/ical/otpef10f3afpfs6u3ljcu2fsa0%40group.calendar.google.com/public/basic.ics";
                      limit = 5;
                    };
                    template = builtins.readFile ./config/ical-events.file;
                  }
               ];
              }
           ];
         }
      ];
    };
  };
  services.glance-ical-events = {
    enable = true;
    host = "0.0.0.0";  # Bind to all interfaces
    port = 8076;
    workers = 4;
  };
}
