{ pkgs, lib, ... }:
{
  options.wireguard.allowedIPs = {
    phone = lib.mkOption {
      type = lib.types.str;
      default = "10.100.0.2/32";
    };
    desktop = lib.mkOption {
      type = lib.types.str;
      default = "10.100.0.3/32";
    };
    vps = lib.mkOption {
      type = lib.types.str;
      default = "10.100.0.4/32";
    };
    laptop = lib.mkOption {
      type = lib.types.str;
      default = "10.100.0.5/32";
    };
  };
  config.environment.systemPackages = [ pkgs.wireguard-tools ];
}
