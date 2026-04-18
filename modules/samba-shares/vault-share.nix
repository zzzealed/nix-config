{ ... }:
{
  services.samba.settings = {
    "vault" = {
      "path" = "/vault";
      "browseable" = "yes";
      "read only" = "no";
      "guest ok" = "no";
      "inherit acls" = "yes";
      "inherit permissions" = "yes";
      "valid users" = "@vault @media";
      "write list" = "@vault";
      "read list" = "@media";
    };
 };
}
