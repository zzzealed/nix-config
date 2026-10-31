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
      "*.internal".port = 2267;

      "srv1.zzzealed.com".port = 2267;
      "vps1.zzzealed.com".port = 2267;
      "rpi1.zzzealed.com".port = 2267;
    };
  };
}
