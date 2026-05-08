{
  pkgs,
  config,
  ...
}:
{
  age.secrets."pr-tracker_github-token".file = ../../secrets/pr-tracker_github-token.age;

  systemd.services.pr-tracker = {
    path = [ pkgs.git ]; # 10 hours of debugging later...
    after = [ "git-prune-nixpkgs.service" ];
    requires = [ "pr-tracker.socket" ];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.pr-tracker}/bin/pr-tracker \
        --path /var/lib/git/nixpkgs.git \
        --remote origin \
        --user-agent 'pr-tracker by alyssais' \
        --source-url https://git.qyliss.net/pr-tracker \
        --mount /
      '';
      StandardInput = "file:${config.age.secrets."pr-tracker_github-token".path}";
      DynamicUser = true;
      SupplementaryGroups = "nixpkgs";
      UMask = "0002";
      ReadWritePaths = "/var/lib/git/nixpkgs.git";
    };
  };

  systemd.sockets.pr-tracker = {
    wantedBy = [ "sockets.target" ];
    before = [ "nginx.service" ];
    socketConfig.ListenStream = "/run/pr-tracker.sock";
  };

  services.nginx.virtualHosts."pr-tracker.l.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations."/".proxyPass = "http://unix:/run/pr-tracker.sock:";
  };
}
