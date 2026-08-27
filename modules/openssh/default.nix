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
      host server.zzzealed.com
        Port 2267
        
      host vps.zzzealed.com
        Port 2267

      Host 10.100.0.1 server.internal
        Port 2267

      Host 10.100.0.2 desktop.internal
        Port 2267

      Host 10.100.0.3 pi.internal
        Port 2267

      Host 10.100.0.4 vps.internal
        Port 2267

      Host 10.100.0.5 laptop.internal
        Port 2267

      Host 10.100.0.6 phone.internal
        Port 2267

      Host *
        SetEnv TERM=xterm-256color
        SendEnv COLORTERM TERM_PROGRAM TERM_PROGRAM_VERSION
    '';
  };
}
