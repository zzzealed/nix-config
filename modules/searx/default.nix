{ config, pkgs, ... }:
{
  age.secrets."searx-secret_key".file = ../../secrets/searx-secret_key.age;
  services.searx = {
    enable = true;
    package = pkgs.searxng;
    settings = {
      server.port = 8609;
      server.bind_address = "0.0.0.0";
      server.secret_key = config.age.secrets."searx-secret_key".path;
      search.formats = [
        "html"
        "json"
      ]; # For OpenWebUI
    };
  };
  #networking.firewall = { allowedTCPPorts = [ config.services.searx.settings.server.port ]; };
  services.nginx.virtualHosts."searx.l.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.searx.settings.server.port}";
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
