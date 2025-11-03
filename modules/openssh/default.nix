{ ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "prohibit-password";
      X11Forwarding = true;
    };
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key"; # /etc/ssh/ssh_host_ed25519_key
        type = "ed25519";
      }
    ];
  };
}
