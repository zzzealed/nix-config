{ cfg, pkgs, inputs, ... }:
{
  imports = [ inputs.nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = true;
    user = "mads";
    legcord = {
      enable = true;
      package = pkgs.unstable.legcord;
      vencord.enable = true;
      settings = {
        minimizeToTray = false;
        mods = [ "vencord" ];
        tray = false;
      };
    };
    config = {
      # No idea why this doesn't work
      #themes."stylix" = cfg.themeBody + cfg.extraCss;
      #enabledThemes = [ "stylix.css" ];
      plugins = {
        alwaysTrust.enable = true;
        customIdle.enable = true;
        platformIndicators.enable = true;
      };
    };
  };
}
