{ ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "prohibit-password";
    };
    hostKeys = [
      {
        path = "/home/mads/.ssh/id_ed25519";
        type = "ed25519";
      }
    ];
  };
}
