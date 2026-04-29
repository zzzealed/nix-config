{ config, pkgs, ... }:
{
  age.secrets."forgejo_nix-config_token-file".file = ../../secrets/forgejo_nix-config_token-file.age;

  services.gitea-actions-runner = {
    package = pkgs.forgejo-runner;
    instances = {
      default = {
        enable = true;
        name = "server-nixos";
        url = "https://git.zzzealed.com";
        tokenFile = config.age.secrets."forgejo_nix-config_token-file".path; # See `secrets/forgejo_nix-config_token-file.example`
        settings = {
          runner = {
            capacity = 1;
          };
        };
        hostPackages = [
          pkgs.nix
          pkgs.git
          pkgs.nodejs
          pkgs.bash
        ];
        labels = [ "nix:host" ]; # Hopefully this never ever backfires on me
      };
    };
  };
}
