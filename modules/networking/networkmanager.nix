{ ... }:
{
  networking = {
    resolvconf.enable = true;
    networkmanager = {
      enable = true;
      dns = "none";
    };
  };
}
