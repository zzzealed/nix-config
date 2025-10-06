{ ... }:
{
  services.scrutiny = {
    enable = true;
    openFirewall = true;
    collecter.enable = true;
    settings.web.listen.port = 50236;
  };
}
