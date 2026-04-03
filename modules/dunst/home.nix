{ ... }:
{
  # TODO: bind `dunstctl close`
  services.dunst = {
    enable = true;
    settings = {
      global.follow = "mouse"; # Show at focused window
    };
  };
}
