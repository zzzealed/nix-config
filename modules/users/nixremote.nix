{ ... }:
{
  users = {
    users.nixremote = {
      group = "nixremote";
      isSystemUser = true;
      useDefaultShell = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGZC8ane6UR7uIaTYLdbcmA7i6IktLhhCbHj/K3uaRbA nixremote@server.internal"
      ];
    };
    groups.nixremote = { };
  };

  nix.settings.trusted-users = [ "nixremote" ];
}
