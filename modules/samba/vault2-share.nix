{ ... }:
{
  services.samba.settings = {
    "vault2" = {
      "path" = "/vault2";
      "browseable" = "yes";
      "read only" = "no";
      "guest ok" = "no";
      "inherit acls" = "yes";
      "inherit permissions" = "yes";
      "valid users" = "@vault2";
      "write list" = "@vault2";
    };
  };
}
