{ lib, config, ... }:
{
  options.nameserver = {
    primary = lib.mkOption {
      type = lib.types.str;
      default = "1.1.1.1";
    };
    secondary = lib.mkOption {
      type = lib.types.str;
      default = "1.0.0.1";
    };
  };

  config.networking.nameservers = [
    config.nameserver.primary
    config.nameserver.secondary
  ];
}
