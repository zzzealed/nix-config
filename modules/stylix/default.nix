{ inputs, lib, pkgs, ... }:
{
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = {
    enable = true;
    autoEnable = true;
    image = ./config/black.png; # Not implemented yet for Niri's background. See: https://github.com/nix-community/stylix/issues/799
    base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/danqing.yaml";
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.code-new-roman;
        name = "CodeNewRoman Nerd Font";
      };
    };
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    icons.enable = true;
    opacity.popups = "0.75";
 };
 # A specialisation you can use when rebuild with `--specialistation <light-theme | dark-theme>`
 # See: https://wiki.nixos.org/wiki/Specialisation
 specialisation = {
   light-theme.configuration = {
     stylix = {
       #image = ./config/wallhaven-d6m68g_1920x1080.png;
       base16Scheme = "${pkgs.base16-schemes}/share/themes/danqing-light.yaml";
       polarity = "light";
     };
   };
   dark-theme.configuration = {
     stylix = {
       #image = ./config/wallhaven-rr5rq7_1920x1080.png;
       base16Scheme = "${pkgs.base16-schemes}/share/themes/danqing.yaml";
       polarity = "dark";
     };
   };
 };
}
