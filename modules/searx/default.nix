{ config, pkgs, ... }:
{
  age.secrets.searx.file = ../../secrets/searx-secret_key.age;
  services.searx = {
    enable = true;
    package = pkgs.searxng;
    settings = {
      server.port = 8609;
      server.bind_address = "0.0.0.0";
      server.secret_key = config.age.secrets.searx-secret_key.path;
    };
  };
}
