{ config, inputs, ... }:
{
  imports = [ inputs.glance-ical-events.nixosModules.default ];

  age.secrets."glance-weather_location".file = ../../secrets/glance-weather_location.age;
  age.secrets."glance-custom-api_kredslob_skrald".file = ../../secrets/glance-custom-api_kredslob_skrald.age;

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
                    type = "weather";
                    units = "metric";
                    hour-format = "24h";
                    location = { _secret = config.age.secrets."glance-weather_location".path; };
                  }
                  {
                    type = "server-stats";
                    servers = [
                      {
                        type = "local";
                        name = "server-nixos";
                        hide-mountpoints-by-default = false;
                      }
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
                        title = "Karakeep";
                        url = "http://192.168.0.118:7890";
                        icon = "sh:karakeep";
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
                  {
                    type = "bookmarks";
                    groups = [
                      {
                        links = [
                          {
                            title = "YouTube";
                            url = "https://www.youtube.com/feed/subscriptions";
                          }
                          {
                            title = "Github";
                            url = "https://github.com/notifications";
                          }
                          {
                            title = "Reddit";
                            url = "https://www.reddit.com";
                          }
                          {
                            title = "Steam";
                            url = "https://store.steampowered.com";
                          }
                          {
                            title = "Proton mail";
                            url = "https://mail.proton.me";
                          }
                          {
                            title = "IsThereAnyDeal";
                            url = "https://isthereanydeal.com/deals/#filter:N4IgZgNghg5iBcIASIC%2BQ%3D%3D%3Ds";
                          }
                          {
                            title = "HBD dashboard";
                            url = "https://38.ein.itsby.design";
                          }
                          {
                            title = "Liquipedia";
                            url = "https://liquipedia.net";
                          }
                          {
                            title = "HLTV";
                            url = "https://hltv.org";
                          }
                          {
                            title = "Apex Comp calendar";
                            url = "https://calendar.google.com/calendar/embed?src=9ad286735043bbfc1494408580cbe6246b9d92988537e4549053f9e6866d63b3@group.calendar.google.com&ctz=Europe/Copenhagen";
                          }
                          {
                            title = "CoC Esports news";
                            url = "https://esports.clashofclans.com/news";
                          }
                          {
                            title = "r/Piracy megathread";
                            url = "https://www.reddit.com/r/Piracy/wiki/megathread";
                          }
                          {
                            title = "r/Piracy Lemmy instance";
                            url = "https://lemmy.dbzer0.com/c/piracy";
                          }
                          {
                            title = "FMHY posts";
                            url = "https://fmhy.net/posts";
                          }
                        ];
                      }
                    ];
                  }
                  {
                    type = "twitch-channels";
                    channels = [
                      "richardlewisreports"
                      "tempohrl"
                      "tr3bla_"
                      "oski_rl"
                      "dralii"
                      "majicbearrl"
                      "zenrll"
                      "atowwwww"
                      "feer"
                      "nicewigg"
                      "apparentlyjack_rl"
                      "vatira_"
                      "rocketleague"
                      "rlesports"
                      "feinberg"
                      "johnnyboi_i"
                      "retalsrl"
                      "imperialhal__"
                      "oilrats"
                      "nassrll_"
                      "ow_esports"
                      "genburten"
                      "ohnepixel"
                    ];
                  }
                ];
              }
              {
                size = "full";
                widgets = [
                  {
                    type = "videos";
                    channels = [
                      "UCRLM6B6rGXDSJawUH_mHHPw"
                      "UC0cd_-e49hZpWLH3UIwoWRA"
                      "UClCNSSL0q1TafS8kaYEAwew"
                      "UCj-wTLj0p0YvTkS-9-ACm0A"
                      "UC28n0tlcNSa1iPe5mettocg"
                      "UCE_BYUUN0I04cAmk1c40sTg"
                      "UC7Ucs42FZy3uYzjrqzOIHsw"
                      "UCTSRIY3GLFYIpkR2QwyeklA"
                      "UCOPeeimwxtWjRDgim96Sxlg"
                      "UCVWhVAZwCdQsPZL-mDLcxPQ"
                      "UCdyZ-HOwl8zSdyfieRURWfg"
                      "UCiflacceDTPX3_SJG3Uiqkg"
                      "UCEOQ9pSmMEIqfhtCDa2JORw"
                      "UCnuk6QPjyRA_SCE4I6RcPbA"
                      "UCGtVx6kynsJRHynh8tqFE9w"
                      "UCRYOj4DmyxhBVrdvbsUwmAA"
                      "UC3ltptWa0xfrDweghW94Acg"
                      "UCLIA48HKtdafC9Nme0gTrkg"
                      "UCRbOPaGDB_xOQkVM8Rnn62Q"
                      "UC2C_jShtL725hvbm1arSV9w"
                      "UCGSy94LzKYY0k3ycxmE9qhQ"
                      "UClt01z1wHHT7c5lKcU8pxRQ"
                      "UCgv4dPk_qZNAbUW9WkuLPSA"
                      "UCm8EsftbfNzSiRHzc7I59KQ"
                      "UCVo63lbKHjC04KqYhwSZ_Pg"
                      "UCxLYtICsUCWdr1YPrj5DtwA"
                      "UC1DTYW241WD64ah5BFWn4JA"
                      "UCFQMnBA3CS502aghlcr0_aw"
                      "UCSdma21fnJzgmPodhC9SJ3g"
                      "UCW76vR0-kSH5JWXJs35RAiQ"
                      "UCZy7hPGKvkDxWmXvJoGPf3g"
                      "UCDW4vtn9Tt39DeIO5aSpXsg"
                      "UCtQ3NfmlxDDWyhfxxgOsJhA"
                      "UCRcgy6GzDeccI7dkbbBna3Q"
                      "UCsnGwSIHyoYN0kiINAGUKxg"
                      "UCYGDiVemmhY_Q1M-hKp4fvw"
                    ];
                  }
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
                  {
                    type = "calendar";
                    first-day-of-week = "monday";
                  }
                  {
                    type = "markets";
                    chart-link-template = "https://finance.yahoo.com";
                    symbol-link-template = "https://finance.yahoo.com/quote/{SYMBOL}";
                    markets = [
                      {
                        symbol = "^GSPC";
                        name = "S&P 500";
                      }
                      {
                        symbol = "^DJI";
                        name = "Dow Jones Industrial Average";
                      }
                      {
                        symbol = "^IXIC";
                        name = "NASDAQ Composite";
                      }
                    ];
                  }
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
                  {
                    type = "custom-api";
                    title = "Kredslob skrald";
                    cache = "15m";
                    url = "http://0.0.0.0:8076/events";
                    parameters = {
                      url = { _secret = config.age.secrets."glance-custom-api_kredslob_skrald".path; };
                      limit = 5;
                    };
                    template = builtins.readFile ./config/ical-events.file;
                  }
                  {
                    type = "releases";
                    show-sources-icon = true;
                    limit = 5;
                    repositories = [
                      "pi-hole/pi-hole"
                      "analogj/scrutiny"
                      "xtekky/gpt4free"
                      "glide-browser/glide"
                      "yalter/niri"
                      "jetkvm/kvm"
                      "helix-editor/helix"
                      "dani-garcia/vaultwarden"
                      "atlas-os/atlas"
                      "mpv-player/mpv"
                      "servo/servo"
                      "glanceapp/glance"
                      "open-webui/open-webui"
                      "home-assistant/core"
                      "dgtlmoon/changedetection.io"
                      "gorhill/uBlock"
                      "mastermindzh/tidal-hifi"
                      "sharkdp/bat"
                      "localsend/localsend"
                      "yt-dlp/yt-dlp"
                    ];
                  }
#                  {
#                    type = "custom-api";
#                    title = "HBD qBittorrent";
#                    cache = "10s";
#                    options = [
#                      { view = "detailed"; }
#                      { mode = "upload"; }
#                    ];
#                  }
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
