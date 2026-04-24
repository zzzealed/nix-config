{ pkgs, ... }:
{
  services.ntfy-sh = {
    enable = true;
    package = pkgs.ntfy-sh;
    settings = {
      base-url = "https://ntfy.rotte.city";
      listen-http = ":8181";
    };
  };
  services.nginx = {
    virtualHosts."ntfy.rotte.city" = {
      useACMEHost = "rotte.city";
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8181";
        proxyWebsockets = true;
        # For testing, forward with `ssh -L 8000:localhost:8181 mads@rotte.city`
        extraConfig = ''
          allow 10.100.0.0/16;
          deny all;
        '';
      };
    };
  };
}
