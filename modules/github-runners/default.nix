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

  # Repo
  systemd.tmpfiles.rules = [
    "d /var/lib/nix-config 0755 root root -"
  ];

  systemd.services.nix-config-sync = {
    description = "Sync nix-config mirror";
    path = [ pkgs.git ];
    serviceConfig.Type = "oneshot";
    script = ''
      repo=/var/lib/nix-config
      if [ -d "$repo/.git" ]; then
        git -C "$repo" fetch origin main
        git -C "$repo" reset --hard origin/main
      else
        git clone https://github.com/zzzealed/nix-config "$repo"
      fi
    '';
  };

  security.sudo.extraRules = [
    {
      users = [ "github-runner-server-nixos" ];
      commands = [
        {
          command = "systemctl start nix-config-sync.service";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
