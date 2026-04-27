{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [ inputs.teapot.nixosModules.default ];

  services.teapot = {
    enable = true;
    package = inputs.teapot.packages.${pkgs.system}.default;
    server = {
      hostname = "twitter.l.zzzealed.com";
      port = 2525;
      publicPort = 443; # `null` just removes the option from the config lol
      https = true;
    };
    config.enableDebug = true;
    #openFirewall = true;
  };
  services.nginx.virtualHosts."twitter.l.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations."/".proxyPass = "http://127.0.0.1:${toString config.services.teapot.server.port}";
  };
}
