{ config, ... }:
{
  imports = [ ./client.nix ];
  networking.wg-quick.interfaces.wg-server = {
    address = [ config.wireguard.ip.laptop ];
    privateKeyFile = config.age.secrets."laptop-server_private-key-file".path;
  };
  age.secrets."laptop-server_private-key-file".file =
    ../../secrets/laptop-server_private-key-file.age;
}
