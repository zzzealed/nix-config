{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    package = pkgs.openssh;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        identityFile = [
          "~/.ssh/id_ed25519_sk"
          "~/.ssh/id_ed25519"
        ];
        identityAgent = "none";
        addKeysToAgent = "yes";
        setEnv.TERM = "xterm-256color";
        sendEnv = [
          "COLORTERM"
          "TERM_PROGRAM"
          "TERM_PROGRAM_VERSION"
        ];
      };
      "server.zzzealed.com".port = 2267;
      "vps.zzzealed.com".port = 2267;
      "pi.zzzealed.com".port = 2267;
      "10.100.0.1 server.internal".port = 2267;
      "10.100.0.2 desktop.internal".port = 2267;
      "10.100.0.3 pi.internal".port = 2267;
      "10.100.0.4 vps.internal".port = 2267;
      "10.100.0.5 laptop.internal".port = 2267;
      "10.100.0.6 phone.internal".port = 2267;
    };
  };
}
