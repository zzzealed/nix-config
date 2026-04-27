{ ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "prohibit-password";
      X11Forwarding = true;
    };
    extraConfig = ''
      AcceptEnv COLORTERM TERM_PROGRAM TERM_PROGRAM_VERSION
    '';
    ports = [
      22
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
    extraConfig = ''
      Host vps.rotte.city
        HostName vps.rotte.city
        Port 2222
    
      Host *
        SetEnv TERM=xterm-256color
        SendEnv COLORTERM TERM_PROGRAM TERM_PROGRAM_VERSION
    '';
  };
}
