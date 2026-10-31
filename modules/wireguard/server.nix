# https://git.ibsenware.org/nix-monorepo.git/tree/hosts/ahmed/wireguard-vpn/default.nix
{ hosts, config, ... }:
{
  # Forward packets from wireguard onto the LAN while also doing address translation.
  networking.nat = {
    enable = true;
    externalInterface = hosts.srv1.iface;
    internalInterfaces = [ hosts.srv1.wgIface ];
  };

  age.secrets."private-key-file".file =
    ../../secrets/wireguard-server/wireguard-server_private-key-file.age;

  networking.wireguard.interfaces.${hosts.srv1.wgIface} = {
    ips = [ "${hosts.srv1.wgIp}/16" ];
    listenPort = hosts.srv1.wgPort;
    privateKeyFile = config.age.secrets.private-key-file.path;
    peers = [
      # Use `wg genkey | tee privatekey | wg pubkey > publickey`
      {
        publicKey = "XMCJMtafOPYB7AfeagRsBwLeSiQwlLG9ROSTRKb0cnc=";
        allowedIPs = [ "${hosts.desktop1.wgIp}/32" ];
      }
      {
        publicKey = "5GtPoPLLuDg7UtwjFf/MGNCMVuDQuXkhmmEoiHuAQEk=";
        allowedIPs = [ "${hosts.rpi1.wgIp}/32" ];
      }
      {
        publicKey = "V394OFPPgENEJtPt4sBgXTsfxK4uJdL0fA5VEZm+Lz4=";
        allowedIPs = [ "${hosts.vps1.wgIp}/32" ];
      }
      {
        publicKey = "V0RHu8VbSOOfakSn28cYdqMwhSlbg1mkdAE2A+7LSSA=";
        allowedIPs = [ "${hosts.laptop1.wgIp}/32" ];
      }
      {
        publicKey = "mDqSq2R3ZN8eI7Jeh53w79QGNoE079rTC/8dI4uyoEs=";
        allowedIPs = [ "${hosts.phone1.wgIp}/32" ];
      }
    ];
  };
  networking.firewall.allowedUDPPorts = [
    config.networking.wireguard.interfaces.${hosts.srv1.wgIface}.listenPort
  ];
}
