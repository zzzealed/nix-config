# https://git.ibsenware.org/nix-monorepo.git/tree/hosts/ahmed/wireguard-vpn/default.nix
{ pkgs, config, ... }:
{
  age.secrets."wireguard_private-key".file = ../../secrets/wireguard_private-key.age;

  environment.systemPackages = [ pkgs.wireguard-tools ];

  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.100.0.1/16" ];
    listenPort = 51820;
    # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
    postSetup = "${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/16 -o enu1u1u1 -j MASQUERADE";
    postShutdown = "${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/16 -o enu1u1u1 -j MASQUERADE";

    privateKeyFile = config.age.secrets.wireguard_private-key.path;
    peers = [
      {
        # phone-nix
        publicKey = "bmX/vHEwIteNYly02k79UtlaEsMYz4n8aabEY6eohUA=";
        allowedIPs = [ "10.100.0.2/32" ];
      }
    ];
  };

  # Allow connections to the wireguard server. All clients need to connect to
  # this port.
  networking.firewall.allowedUDPPorts = [ config.networking.wireguard.interfaces.wg0.listenPort ];

  # Forward packets from wireguard onto the LAN while also doing address translation.
  networking.nat = {
    enable = true;
    externalInterface = "enu1u1u1";
    internalInterfaces = [ "wg0" ];
  };
}
