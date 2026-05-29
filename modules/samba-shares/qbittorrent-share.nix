{ ... }:
{
  services.samba.settings = {
    "qbittorrent" = {
      "path" = "/var/lib/qBittorrent/qBittorrent/downloads";
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
