{ pkgs, ... }:
{
  services.authelia.instances.main = {
    enable = true;
    package = pkgs.authelia;
    secrets = {
      # ...
    };
    settings = {
      # ...
    };
  };
}
