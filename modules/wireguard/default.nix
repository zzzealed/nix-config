{ pkgs, lib, ... }:
{
  config.environment.systemPackages = [ pkgs.wireguard-tools ];

  options.wireguard = {
    serverPort = lib.mkOption {
      type = lib.types.int;
      default = 51820;
    };
    clientAllowedIPs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "0.0.0.0/0"
        "::/0"
      ];
    };
    ip = {
      server = lib.mkOption {
        type = lib.types.str;
        default = "10.100.0.1/16";
      };
      desktop = lib.mkOption {
        type = lib.types.str;
        default = "10.100.0.2/32";
      };
      pi = lib.mkOption {
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
      phone = lib.mkOption {
        type = lib.types.str;
        default = "10.100.0.6/32";
      };
    };
  };
}
