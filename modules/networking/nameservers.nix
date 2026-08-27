{ lib, config, ... }:
{
  options.nameserver = {
    server = lib.mkOption {
      type = lib.types.str;
      default = "10.100.0.1"; # server w/ Pihole
    };
    secondary = lib.mkOption {
      type = lib.types.str;
      default = "1.1.1.1"; # Cloudflare
    };
  };

  config.networking.nameservers = [
    config.nameserver.server
    config.nameserver.secondary
  ];
}
