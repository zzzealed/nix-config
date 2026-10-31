{ ... }:
{
  wsl = {
    enable = true;
    defaultUser = "mads";
    wslConf.network.generateHosts = false;
  };
}
