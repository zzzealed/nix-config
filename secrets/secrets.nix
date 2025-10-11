let
  root_desktop-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEU3Cy4L/zlUm3lJmVbeN5XnnKA1us4incL+d6JH4Dg9 root@nixos";
  root_server-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB/rJS1hRE1N7E7B52yBPb1fkDwWaP6oYtF+3/ArdK8l root@nixos";
  decodingKeys = [ root_desktop-nixos root_server-nixos ];
    
  mads_desktop-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL0bskvLTrkiFLQeS4K1uc8EwNGXrCcigrRZa/dPcycI mads@desktop-nixos";
  mads_server-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOo+0J8abiPou6UWCuolKS0RriZ5zAYrgV2zdgIYTuQ5 mads@server-nixos";
  interactiveKeys = [ mads_desktop-nixos mads_server-nixos ];
in
{
  "mads-password.age" = {
    publicKeys = decodingKeys ++ [ mads_desktop-nixos mads_server-nixos ];
    armor = true;
  };
  "searx-secret_key.age" = {
    publicKeys = [ root_server-nixos mads_desktop-nixos mads_server-nixos ];
    armor = true;
  };
}
