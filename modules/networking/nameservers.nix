{ lib, config, ... }:
{
  options.nameserver = {
    server = lib.mkOption {
      type = lib.types.str;
      default = "192.168.0.118"; # server w/ Pihole
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
