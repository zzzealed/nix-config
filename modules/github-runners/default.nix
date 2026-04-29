{ config, pkgs, ... }:
{
  age.secrets."github_nix-config_token-file".file = ../../secrets/github_nix-config_token-file.age;
  services.github-runners = {
    server-nixos = {
      enable = true;
      package = pkgs.github-runner;
      name = "server-nixos";
      url = "https://github.com/zzzealed/nix-config";
      tokenFile = config.age.secrets."github_nix-config_token-file".path;
      extraPackages = [
        pkgs.nix
        pkgs.git
        pkgs.bash
      ];
      extraLabels = [ "nix" ];
    };
  };
}
