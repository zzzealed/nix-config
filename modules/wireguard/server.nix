# https://git.ibsenware.org/nix-monorepo.git/tree/hosts/ahmed/wireguard-vpn/default.nix
{ config, ... }:
let
  externalInterface = "enp3s0";
  internalInterface = "wg0";
in
{
  # Forward packets from wireguard onto the LAN while also doing address translation.
  networking.nat = {
    enable = true;
    externalInterface = externalInterface;
    internalInterfaces = [ internalInterface ];
  };

  age.secrets."wireguard-server_private-key-file".file =
    ../../secrets/wireguard-server_private-key-file.age;

  networking.wireguard.interfaces.${internalInterface} = {
    ips = [ config.wireguard.ip.server ];
    listenPort = config.wireguard.serverPort;
    privateKeyFile = config.age.secrets.wireguard-server_private-key-file.path;
    peers = [
      # Use `wg genkey | tee privatekey | wg pubkey > publickey`
      {
        publicKey = "dpqVyuEXtxNzOD71u4YZS2SIOYO7bjRtnudLqI4/Mls=";
        allowedIPs = [ config.wireguard.ip.desktop ];
      }
      {
        publicKey = "5GtPoPLLuDg7UtwjFf/MGNCMVuDQuXkhmmEoiHuAQEk=";
        allowedIPs = [ config.wireguard.ip.pi ];
      }
      {
        publicKey = "V394OFPPgENEJtPt4sBgXTsfxK4uJdL0fA5VEZm+Lz4=";
        allowedIPs = [ config.wireguard.ip.vps ];
      }
      {
        publicKey = "V0RHu8VbSOOfakSn28cYdqMwhSlbg1mkdAE2A+7LSSA=";
        allowedIPs = [ config.wireguard.ip.laptop ];
      }
      {
        publicKey = "mDqSq2R3ZN8eI7Jeh53w79QGNoE079rTC/8dI4uyoEs=";
        allowedIPs = [ config.wireguard.ip.phone ];
      }
    ];
  };
  networking.firewall.allowedUDPPorts = [ config.wireguard.serverPort ];
}
