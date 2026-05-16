{ config, pkgs, ... }:
{
  services.qbittorrent = {
    enable = true;
    package = pkgs.qbittorrent-nox;
    torrentingPort = 41775;
    webuiPort = 1337;
    serverConfig = {
      Preferences = {
        WebUI = {
          Username = "mads";
          Password_PBKDF2 = "@ByteArray(Lq+hF/JGD3e0oludEJ2xcQ==:n56jFApNg89rJMHKbq7c6nUkUA0C0xG8TFQ6eOV8I20TlZQP6jxc6IoBoSJcDgGZFNH/pU73Wxz0sBSJgV2Dqg==)";
          LocalHostAuth = false;
          AuthSubnetWhitelist = "10.100.0.0/16, 192.168.0.0/24";
          AuthSubnetWhitelistEnabled = true;
        };
        Advanced = {
          NetworkInterface = "wg_hbd-2";
        };
      };
    };
  };
  services.nginx.virtualHosts."qbit.l.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.qbittorrent.webuiPort}";
      extraConfig = ''
        proxy_set_header Host localhost:1337;
        auth_request /internal/authelia/authz;
        auth_request_set $redirection_url $upstream_http_location;
        error_page 401 =302 $redirection_url;
      '';
    };
    locations."/internal/authelia/authz" = {
      extraConfig = ''
        internal;
        proxy_pass http://127.0.0.1:9091/api/authz/auth-request;
        proxy_set_header X-Original-Method $request_method;
        proxy_set_header X-Original-URL $scheme://$http_host$request_uri;
        proxy_pass_request_body off;
      '';
    };
  };
}
