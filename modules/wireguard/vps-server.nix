{ config, ... }:
{
  imports = [ ./client.nix ];
  wireguard.clientAllowedIPs = [
    "10.100.0.0/24"
    "192.168.0.0/24"
    "192.168.8.0/24"
  ];
  networking.wg-quick.interfaces.wg-server = {
    address = [ config.wireguard.ip.vps ];
    privateKeyFile = config.age.secrets."vps-server_private-key-file".path;
  };
  age.secrets."vps-server_private-key-file".file = ../../secrets/vps-server_private-key-file.age;
}
