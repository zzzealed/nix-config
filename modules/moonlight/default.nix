{ pkgs, ... }:
{
  programs.moonlight-qt = {
    enable = true;
    package = pkgs.moonlight-qt;
    capSysNice = true;
  };
}
