{ pkgs, ... }:
{
  services.endlessh-go = {
    enable = true;
    package = pkgs.endlessh-go;
    port = 2222; # Router port-forward 2222 <- 22
    openFirewall = true;
  };
}
