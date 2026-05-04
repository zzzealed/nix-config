{
  pkgs,
  inputs,
  ...
}:
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
        hardwareAcceleration = true;
        doneSetup = true;
      };
    };
    config = {
      useQuickCss = false;
      themes = {
        "stylix.theme.css" = "/home/mads/.config/legcord/themes/stylix.theme.css";
      };
      enabledThemes = [ "stylix.theme.css" ];
      plugins = {
        alwaysTrust.enable = true;
        customIdle.enable = true;
        platformIndicators.enable = true;
      };
    };
  };
}
