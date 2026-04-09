{ pkgs, ... }:
{
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    # Create databases
    ensureDatabases = [ "db1" ];
  
    # Create users and grant permissions
    ensureUsers = [
      {
        name = "user1";
        ensurePermissions = {
          "db1.*" = "ALL PRIVILEGES";
        };
      }
    ];
  };
}
