{ pkgs, ... }:
{
  services.gnome.gcr-ssh-agent.enable = false;
  services.openssh = {
    enable = true;
    package = pkgs.openssh;
    settings = {
      PasswordAuthentication = false;
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
}
