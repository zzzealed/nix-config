{ ... }:
{
  services.samba.settings = {
    "vault2" = {
      "path" = "/vault2";
      "browseable" = "yes";
      "read only" = "no";
      "guest ok" = "no";
      "create mask" = "0644";
      "directory mask" = "0755";
      "force user" = "mads";
      #"force group" = "samba";
    };
 };
}
