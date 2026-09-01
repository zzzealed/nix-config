{ config, ... }:
{
  imports = [ ./client.nix ];
  wireguard.clientAllowedIPs = [
    "10.100.0.0/24"
    "192.168.0.0/24"
  ];
  networking.wg-quick.interfaces.wg-server = {
    address = [ config.wireguard.ip.desktop ];
    privateKeyFile = config.age.secrets."desktop-server_private-key-file".path;
  };
  age.secrets."desktop-server_private-key-file".file =
    ../../secrets/desktop-server_private-key-file.age;
}
