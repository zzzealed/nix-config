{ ... }:
{
  services.unbound = {
    enable = true;
    settings = {
      server = {
        verbosity = 0;
        interface = [ "0.0.0.0" ];
        port = 5335;
        access-control = "192.168.0.0/16 allow";
        private-address = [
          "192.168.0.0/16"
          "169.254.0.0/16"
          "172.16.0.0/12"
          "10.0.0.0/8"
          "fd00::/8"
          "fe80::/10"
          # Ensure no reverse queries to non-public IP ranges (RFC6303 4.2)
          "192.0.2.0/24"
          "198.51.100.0/24"
          "203.0.113.0/24"
          "255.255.255.255/32"
          "2001:db8::/32"
        ];
        # Recursive resolution settings
        do-ip4 = true;
        do-ip6 = true;
        do-udp = true;
        do-tcp = true;
        # Security and performance settings
        harden-dnssec-stripped = true;
        use-caps-for-id = false;
        edns-buffer-size = 1232;
        harden-glue = true;
        prefetch = true;
      };
    };
  };
  networking.firewall = {
    allowedUDPPorts = [ 5335 ];
    allowedTCPPorts = [ 5335 ];
  };
}
