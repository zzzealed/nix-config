{ inputs, lib, pkgs, ... }:
let
  # Themes from: https://tinted-theming.github.io/tinted-gallery/
  
  # danqing
  #dark-scheme = "danqing";
  #light-scheme = "danqing-light";

  # da-one
  #dark-scheme = "da-one-black";
  #light-scheme = "da-one-white";

in
{
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = {
    enable = true;
    autoEnable = true;
    targets = {
      glance.enable = false;
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.code-new-roman;
        name = "CodeNewRoman Nerd Font";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "NotoSans";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "NotoSerif";
      };
    };
    cursor = {
      package = pkgs.bibata-cursors;
      size = 24;
    };
    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
    };
    opacity.popups = 0.75;

    # Default theme is dark
    image = lib.mkDefault ./config/wp11286584-adventure-time-night-wallpapers.jpg;
    #base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/${dark-scheme}.yaml";
    base16Scheme = lib.mkDefault ./config/danqing-modified.yaml;
    polarity = lib.mkDefault "dark";
    icons.dark = lib.mkDefault "Papirus-Dark";
    cursor.name = lib.mkDefault "Bibata-Modern-Ice";
 };
 # A specialisation you can use when rebuild with `--specialistation light-theme`
 # See: https://wiki.nixos.org/wiki/Specialisation
 # Also, to reload Fish with new scheme, use: `exec fish`
 specialisation = {
   light-theme.configuration = {
     stylix = {
       image = lib.mkForce ./config/wallhaven-9d7dox_1920x1080.png;
       #base16Scheme = lib.mkForce "${pkgs.base16-schemes}/share/themes/${light-scheme}.yaml";
       base16Scheme = lib.mkForce ./config/danqing-light-modified.yaml;
       polarity = lib.mkForce "light";
       icons.light = lib.mkForce "Papirus-Light";
       cursor.name = lib.mkForce "Bibata-Modern-Classic";
     };
   };
 };
}
