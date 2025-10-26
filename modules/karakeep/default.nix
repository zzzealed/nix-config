{ ... }:
{
  services.karakeep = {
    enable = true;
    extraEnvironment = {
      PORT = "7890";
    };
  };
  networking.firewall = { allowedTCPPorts = [ 7890 ]; };
}
