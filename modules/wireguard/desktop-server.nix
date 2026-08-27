{ config, ... }:
{
  imports = [ ./client.nix ];
  networking.wg-quick.interfaces.wg-server = {
    address = [ config.wireguard.ip.desktop ];
    privateKeyFile = config.age.secrets."desktop-server_private-key-file".path;
  };
  age.secrets."desktop-server_private-key-file".file =
    ../../secrets/desktop-server_private-key-file.age;
}
