{ ... }:
{
  nix.settings = {
    extra-substituters = [ "https://lan-mouse.cachix.org" ];
    extra-trusted-public-keys = [ "lan-mouse.cachix.org-1:KlE2AEZUgkzNKM7BIzMQo8w9yJYqUpor1CAUNRY6OyM=" ];
  };
}
