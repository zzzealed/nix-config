{
  config,
  pkgs,
  ...
}:
let
  octodnsPkg =
    with pkgs.unstable;
    octodns.withProviders (ps: [
      octodns-providers.ddns
      octodns-providers.porkbun
    ]);

  sync = pkgs.writeShellScript "octodns-sync" ''
    export PORKBUN_API_KEY="$(< ${config.age.secrets."porkbun-nginx_api_key".path})"
    export PORKBUN_SECRET_KEY="$(< ${config.age.secrets."porkbun-nginx_api_secret".path})"
    exec ${octodnsPkg}/bin/octodns-sync --config-file=/etc/octodns/manager.yaml --doit
  '';
in
{
  age.secrets."porkbun-nginx_api_key".file = ../../secrets/porkbun-nginx_api_key.age;
  age.secrets."porkbun-nginx_api_secret".file = ../../secrets/porkbun-nginx_api_secret.age;

  environment.etc."octodns".source = ./config + "/${config.networking.hostName}";
  environment.systemPackages = [ octodnsPkg ];

  systemd.services.octodns-sync = {
    description = "OctoDNS DNS synchronization";
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    startAt = "*:0/5"; # Every 5 minutes
    serviceConfig = {
      Type = "oneshot";
      ExecStart = sync;
    };
  };
}
