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
      "*.lan".Port = 2267;
      "*.internal".Port = 2267;

      "srv1.zzzealed.com".Port = 2267;
      "vps1.zzzealed.com".Port = 2267;
      "rpi1.zzzealed.com".Port = 2267;
    };
  };
}
