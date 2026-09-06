{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    package = pkgs.openssh;
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
      "10.100.0.1 server.internal".Port = 2267;
      "10.100.0.2 desktop.internal".Port = 2267;
      "10.100.0.3 pi.internal".Port = 2267;
      "10.100.0.4 vps.internal".Port = 2267;
      "10.100.0.5 laptop.internal".Port = 2267;
      "10.100.0.6 phone.internal".Port = 2267;
    };
  };
}
