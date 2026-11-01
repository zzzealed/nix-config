{ config, pkgs, ... }:
{
  age.secrets."github_nix-config_token-file".file = ../../secrets/github_nix-config_token-file.age;
  services.github-runners = {
    srv1 = {
      enable = true;
      package = pkgs.github-runner;
      name = "srv1";
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
  nix.settings.allowed-users = [ "github-runner-srv1" ];

  # Symlink gcroots
  systemd.tmpfiles.rules = [
    "L+ /nix/var/nix/gcroots/github-runner - - - - /var/lib/github-runner/srv1/gcroots"
  ];
}
