{ ... }:
{
  imports = [ ../gnome-polkit.nix ];
  security.polkit = {
    enable = true;
  };
}
