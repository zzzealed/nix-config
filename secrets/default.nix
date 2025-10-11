{ inputs, system, ... }:
{
  environment.systemPackages = [ inputs.agenix.packages.${system}.default ];
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ]; # /etc/ssh/ssh_host_ed25519_key
}

