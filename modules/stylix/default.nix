{ pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    image = ./config/wallhaven-rr5rq7_1920x1080.png;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.code-new-roman;
        name = "";
      };
    };
    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
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
       base16Scheme = "${pkgs.base16-schemes}/share/themes/danqing-light.yaml";
       polarity = "light";
     };
   };
   dark-theme.configuration = {
     stylix = {
       base16Scheme = "${pkgs.base16-schemes}/share/themes/danqing.yaml";
       polarity = "dark";
     };
   };
 };
}
