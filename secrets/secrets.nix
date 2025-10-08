let
  mads_desktop-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL0bskvLTrkiFLQeS4K1uc8EwNGXrCcigrRZa/dPcycI mads@desktop-nixos";
  mads_server-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOo+0J8abiPou6UWCuolKS0RriZ5zAYrgV2zdgIYTuQ5 mads@server-nixos";
  systems = [ mads_desktop-nixos mads_server-nixos ]; # TODO: make ssh keys without passwords
in
{
  "mads-password.age" = {
    publicKeys = [ mads_desktop-nixos mads_server-nixos ];
    armor = true;
  };
  "searx-secret_key.age" = {
    publicKeys = [ mads_server-nixos ];
    armor = true;
  };
}
