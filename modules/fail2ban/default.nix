{ pkgs, ... }:
{
  services.fail2ban = {
    enable = true;
    package = pkgs.fail2ban;
    ignoreIP = [
      "192.168.0.0/16"
      "10.100.0.0/16" # Wireguard
    ];
    bantime-increment = {
      enable = true;
    };
    jails = {
      # Ban dubious SSH attempts
      sshd.settings = {
        port = "2267";
        action = "nftables-allports[port=2267]";
        maxretry = 3;
      };
      # Add IPs to SSH ban
      endlessh.filter.Definition = {
        _daemon = "endlessh-go";
        failregex = ''^.*ACCEPT host=<HOST> port=\d+ n=\d+/\d+$'';
      };
      endlessh.settings = {
        backend = "systemd";
        journalmatch = "SYSLOG_IDENTIFIER=endlessh-go";
        action = "nftables-allports[port=2267]";
        maxretry = 1;
        bantime = "24h";
      };
    };
  };
}
