{ ... }:
{
  imports = [ ./docker-compose.nix ];
  services.nginx.virtualHosts."chrome.l.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:3000";
      proxyWebsockets = true; # https://docs.linuxserver.io/FAQ/#jammy
      extraConfig = ''
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
