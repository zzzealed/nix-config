{ pkgs, ... }:
{
  services.crowdsec = {
    enable = true;
    package = pkgs.crowdsec;
  };
}
