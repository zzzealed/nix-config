{ lib, ... }:
{
  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings = {
      #dns_enabled = lib.mkForce false; # Free port 53 for Pihole, force because of changedetection-io
    };
  };
}
