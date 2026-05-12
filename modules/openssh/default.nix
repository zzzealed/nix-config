{ pkgs, ... }:
{
  services.openssh = {
    enable = true;
    package = pkgs.openssh;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "prohibit-password";
      X11Forwarding = true;
      LogLevel = "VERBOSE";
    };
    extraConfig = ''
      AcceptEnv COLORTERM TERM_PROGRAM TERM_PROGRAM_VERSION
    '';
    ports = [
      2267
    ];
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key"; # /etc/ssh/ssh_host_ed25519_key
        type = "ed25519";
      }
    ];
  };
  programs.ssh = {
    package = pkgs.openssh;
    extraConfig = ''
      Host 192.168.0.118 server.l.zzzealed.com
        Port 2267

      Host 192.168.0.151 pi.l.zzzealed.com
        Port 2267

      Host 192.168.0.146 desktop.l.zzzealed.com
        Port 2267

      Host 192.168.0.31 laptop2.l.zzzealed.com
        Port 2267

      Host 192.168.0.164 phone.l.zzzealed.com
        Port 2267

      Host 87.104.105.54 home.zzzealed.com
        Port 2267

      Host 79.76.44.104 vps.zzzealed.com
        Port 2267

      Host *
        SetEnv TERM=xterm-256color
        SendEnv COLORTERM TERM_PROGRAM TERM_PROGRAM_VERSION
    '';
  };
}
