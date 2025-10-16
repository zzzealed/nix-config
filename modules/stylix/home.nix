{ config, ... }:
{
  stylix.targets = {
    fuzzel.enable = true;
    swaylock = {
      enable = true;
      useWallpaper = config.stylix.image == null;
    };
  };
}
