{ hosts, config, ... }:
let
  host = hosts.${config.networking.hostName};
  router = hosts.routers.${host.router};
in
{
  networking.networkmanager.ensureProfiles.profiles."lan" = {
    connection = {
      id = "lan";
      type = "ethernet";
      interface-name = host.iface;
    };
    ipv4 = {
      method = "manual";
      addresses = host.lanIp + router.subnet;
      gateway = router.lanIp;
    };
  };
}
