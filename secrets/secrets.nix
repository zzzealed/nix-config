let
  desktop-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL0bskvLTrkiFLQeS4K1uc8EwNGXrCcigrRZa/dPcycI mads@desktop-nixos";
  server-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOo+0J8abiPou6UWCuolKS0RriZ5zAYrgV2zdgIYTuQ5 mads@server-nixos";
  systems = [ desktop-nixos server-nixos ];
in
{
  "mads-password.age" = {
    publicKeys = [ desktop-nixos server-nixos ];
    armor = true;
  };
  "searx-secret_key.age" = {
    publicKeys = [ desktop-nixos server-nixos ];
    armor = true;
  };
}
