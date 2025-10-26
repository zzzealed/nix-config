{ ... }:
{
  services.changedetection-io = {
    enable = true;
    behindProxy = true;
    webDriverSupport = true;
    listenAddress = "0.0.0.0";
  };
  networking.firewall = { allowedTCPPorts = [ 5000 ]; };
}
