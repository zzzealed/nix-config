{ ... }:
{
  # TODO: This is a weird place to put these but I don't know where else to put them
  services.wpaperd.enable = true;
  programs.swaylock.enable = true;

  stylix = {
    targets = {
      swaylock = {
        useWallpaper = true;
      };
    };
  };
}
