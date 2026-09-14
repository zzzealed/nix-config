{ hosts, pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    package = pkgs.openssh;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        IdentityFile = [
          "~/.ssh/id_ed25519_sk"
          "~/.ssh/id_ed25519"
        ];
        IdentityAgent = "none";
        AddKeysToAgent = "yes";
        SetEnv.TERM = "xterm-256color";
        SendEnv = [
          "COLORTERM"
          "TERM_PROGRAM"
          "TERM_PROGRAM_VERSION"
        ];
      };
      "server.zzzealed.com".Port = 2267;
      "vps.zzzealed.com".Port = 2267;
      "pi.zzzealed.com".Port = 2267;

      "${hosts.server.lanIp} server.lan".Port = 2267;
      "${hosts.desktop.lanIp} desktop.lan".Port = 2267;
      "${hosts.pi.lanIp} pi.lan".Port = 2267;
      "${hosts.vps.lanIp} vps.lan".Port = 2267;
      "${hosts.laptop.lanIp} laptop.lan".Port = 2267;
      "${hosts.phone.lanIp} phone.lan".Port = 2267;

      "${hosts.server.wgIp} server.internal".Port = 2267;
      "${hosts.desktop.wgIp} desktop.internal".Port = 2267;
      "${hosts.pi.wgIp} pi.internal".Port = 2267;
      "${hosts.vps.wgIp} vps.internal".Port = 2267;
      "${hosts.laptop.wgIp} laptop.internal".Port = 2267;
      "${hosts.phone.wgIp} phone.lan".Port = 2267;
    };
  };
}
