{ lib, pkgs, ... }:

let
  inherit (pkgs) writeText;
  toGitConfig = lib.generators.toINI { listsAsDuplicateKeys = true; };
in

{
  environment.systemPackages = with pkgs; [ gitMinimal ];

  users.groups.nixpkgs = { };

  environment.etc.gitconfig.text = ''
    [safe]
    	directory = /var/lib/git/nixpkgs.git
  '';

  systemd.tmpfiles.rules = [
    "f /var/lib/git/nixpkgs.git/FETCH_HEAD 0775 - nixpkgs"
    "L+ /var/lib/git/nixpkgs.git/HEAD - - - - refs/heads/master"
    "L+ /var/lib/git/nixpkgs.git/config - - - - ${
      writeText "config" (toGitConfig {
        core.repositoryformatversion = 0;
        core.filemode = true;
        core.bare = true;
        core.sharedRepository = "world";
        fetch.prune = true;
        gc.auto = 6700;
        "remote \"origin\"" = {
          url = "https://github.com/NixOS/nixpkgs";
          tagOpt = "--no-tags";
          fetch = [
            "+refs/heads/master:refs/remotes/origin/master"
            "+refs/heads/staging:refs/remotes/origin/staging"
            "+refs/heads/staging-*:refs/remotes/origin/staging-*"
            "+refs/heads/nixos-*:refs/remotes/origin/nixos-*"
            "+refs/heads/nixpkgs-unstable:refs/remotes/origin/nixpkgs-unstable"
            "+refs/heads/nixpkgs-*-darwin:refs/remotes/origin/nixpkgs-*-darwin"
            "+refs/heads/release-*:refs/remotes/origin/release-*"
          ];
        };
      })
    }"
    "d /var/lib/git/nixpkgs.git 2775 - nixpkgs"
    "d /var/lib/git/nixpkgs.git/refs 2775 - nixpkgs"
    "d /var/lib/git/nixpkgs.git/objects 2775 - nixpkgs"
    "d /var/lib/git/nixpkgs.git/objects/pack 2775 - nixpkgs"
  ];

  systemd.services.git-prune-nixpkgs = {
    path = [ pkgs.gitMinimal ];
    #wantedBy = [ "multi-user.target" ];
    serviceConfig.DynamicUser = true;
    serviceConfig.Group = "nixpkgs";
    serviceConfig.ReadWritePaths = "/var/lib/git/nixpkgs.git";
    serviceConfig.ExecStart = "${pkgs.gitMinimal}/bin/git --git-dir /var/lib/git/nixpkgs.git prune";
    serviceConfig.Type = "oneshot";
    serviceConfig.UMask = "0002";
  };

  systemd.services.git-fetch-nixpkgs = {
    path = [ pkgs.gitMinimal ];
    after = [
      "git-prune-nixpkgs.service"
      "network-online.target"
    ];
    requires = [ "network-online.target" ];
    serviceConfig.DynamicUser = true;
    serviceConfig.Group = "nixpkgs";
    serviceConfig.ReadWritePaths = "/var/lib/git/nixpkgs.git";
    serviceConfig.ExecStart = "${pkgs.gitMinimal}/bin/git --git-dir /var/lib/git/nixpkgs.git fetch";
    serviceConfig.Type = "oneshot";
    serviceConfig.UMask = "0002";
  };

  systemd.timers.git-fetch-nixpkgs = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnActiveSec = 0;
      OnUnitActiveSec = 300;
      Persistent = false;
    };
  };

  systemd.services.git-gc-nixpkgs = {
    path = [ pkgs.gitMinimal ];
    after = [ "git-prune-nixpkgs.service" ];
    serviceConfig.DynamicUser = true;
    serviceConfig.Group = "nixpkgs";
    serviceConfig.ReadWritePaths = "/var/lib/git/nixpkgs.git";
    serviceConfig.ExecStart = "${pkgs.gitMinimal}/bin/git --git-dir /var/lib/git/nixpkgs.git gc --auto --quiet";
    serviceConfig.Type = "oneshot";
    serviceConfig.UMask = "0002";
  };

  systemd.timers.git-gc-nixpkgs = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = false;
    };
  };
}
