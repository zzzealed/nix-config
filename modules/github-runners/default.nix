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
      extraPackages = with pkgs; [
        nix
        git
        bash
        curl
      ];
      extraLabels = [ "nix" ];
    };
  };
  nix.settings.allowed-users = [ "github-runner-server-nixos" ];
  # Symlink gcroots
  systemd.tmpfiles.rules = [
    "L+ /nix/var/nix/gcroots/github-runner - - - - /var/lib/github-runner/server-nixos/gcroots"
  ];
}
