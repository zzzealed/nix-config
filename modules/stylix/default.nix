{ inputs, lib, pkgs, ... }:
let
  # Themes from: https://tinted-theming.github.io/tinted-gallery/
  
  # danqing
  #dark-scheme = "danqing";
  #light-scheme = "danqing-light";

  # danqing-modified
  dark-scheme = ./config/danqing-modified.yaml;
  light-scheme = ./config/danqing-light-modified.yaml; 

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
    #image = lib.mkDefault ./config/wp11286584-adventure-time-night-wallpapers.jpg;
    image = lib.mkDefault (pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/rr/wallhaven-rr5rq7.jpg";
      hash = "sha256-kpLa+UVjUlfRHq24cdBGfD7TPJ/RiSHLijEB1ro9bbQ=";
    });
    base16Scheme = lib.mkDefault "${dark-scheme}";
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
       image = lib.mkForce (pkgs.fetchurl {
         url = "https://w.wallhaven.cc/full/9d/wallhaven-9d7dox.jpg";
         hash = "sha256-OYzqiDNaFlDopzZbTU1YkqV2bOrw/LAup16aA2Jxieo=";
       });
       base16Scheme = lib.mkForce "${light-scheme}";
       polarity = lib.mkForce "light";
       icons.light = lib.mkForce "Papirus-Light";
       cursor.name = lib.mkForce "Bibata-Modern-Classic";
     };
   };
 };
}
