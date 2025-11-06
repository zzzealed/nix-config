{ inputs, lib, pkgs, ... }:
let
  # Themes from: https://tinted-theming.github.io/tinted-gallery/
  
  # danqing
  dark-scheme = "danqing";
  light-scheme = "danqing-light";
 
  # synth-midnight
  #dark-scheme = "synth-midnight-dark";
  #light-scheme = "synth-midnight-light";

  # solarized
  #dark-scheme = "solarized-dark";
  #light-scheme = "solarized-light";

  # solarflare
  #dark-scheme = "solarflare";
  #light-scheme = "solareflare-light";

  # selenized
  #dark-scheme = "selenized-black";
  #light-scheme = "selenized-white";

  # chicago
  #dark-scheme = "chicago-night";
  #light-scheme = "chicago-day";

  # ayu
  #dark-scheme = "ayu-mirage";
  #light-scheme = "ayu-light";

  # atelier-estuary
  #dark-scheme = "atelier-estuary";
  #light-scheme = "atelier-estuary-light";

  # windows-nt
  #dark-scheme = "windows-nt";
  #light-scheme = "windows-nt-light";
in
{
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = {
    enable = true;
    autoEnable = true;
    targets = {
      #grub.enable = false;
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.code-new-roman;
        name = "CodeNewRoman Nerd Font";
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
    image = lib.mkDefault ./config/wallhaven-rr5rq7_1920x1080.png;
    base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/${dark-scheme}.yaml";
    polarity = lib.mkDefault "dark";
    icons.dark = lib.mkDefault "Papirus-Dark";
    cursor.name = lib.mkDefault "Bibata-Modern-Classic";
 };
 # A specialisation you can use when rebuild with `--specialistation light-theme`
 # See: https://wiki.nixos.org/wiki/Specialisation
 specialisation = {
   light-theme.configuration = {
     stylix = {
       image = lib.mkForce ./config/wallhaven-d6m68g_1920x1080.png;
       base16Scheme = lib.mkForce "${pkgs.base16-schemes}/share/themes/${light-scheme}.yaml";
       polarity = lib.mkForce "light";
       icons.light = lib.mkForce "Papirus-Light";
       cursor.name = lib.mkForce "Bibata-Modern-Ice";
     };
   };
 };
}
