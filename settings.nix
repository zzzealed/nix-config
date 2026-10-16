{
  allowUnfree = true;
  experimental-features = [
    "nix-command"
    "flakes"
  ];
  substituters = [
    "https://cache.l.zzzealed.com"
    "https://cache.nixos.org"
    "https://nix-community.cachix.org"
    "https://nix-on-droid.cachix.org"
  ];
  trusted-public-keys = [
    "cache.l.zzzealed.com-1:d29SnNbB+hmWUlqbc6TaYaOP8fv25hlxpQRxgCqLQhE="
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "nix-on-droid.cachix.org-1:56snoMJTXmDRC1Ei24CmKoUqvHJ9XCp+nidK7qkMQrU="
  ];
}
