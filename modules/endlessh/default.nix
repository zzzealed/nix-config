{ pkgs, ... }:
{
  services.endlessh-go = {
    enable = true;
    package = pkgs.endlessh-go;
    port = 22;
    openFirewall = true;
    extraOptions = [
      "-logtostderr"
      "-v=2"
    ];
  };
}
