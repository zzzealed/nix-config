{ ... }:
{
  # TODO: This is a weird place to put these but I don't know where else to put them
  services.wpaperd.enable = true;
  services.swaync.enable = true;
  programs.swaylock.enable = true;
  programs.fuzzel.enable = true;
  programs.mpv.enable = true;
  programs.bat.enable = true;

  stylix = {
    targets = {
      swaylock = {
        useWallpaper = true;
      };
    };
  };
}
