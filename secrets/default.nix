{ inputs, stdenv, ... }:
{
  imports = [ inputs.agenix.nixosModules.default ];
  environment.systemPackages = [ inputs.agenix.packages.${stdenv.hostPlatform.system}.default ];
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ]; # /etc/ssh/ssh_host_ed25519_key
}

